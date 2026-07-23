library(shiny)

# ==========================
# Product Inventory Dataset
# ==========================
inventory <- data.frame(
  ProductID = c(1, 2, 3),
  ProductName = c("Product A", "Product B", "Product C"),
  Quantity = c(250, 175, 300),
  Price = c(20, 15, 18),
  Category = c("Electronics", "Electronics", "Accessories")
)

ui <- fluidPage(
  
  titlePanel("Product Inventory Management Dashboard"),
  
  sidebarLayout(
    
    sidebarPanel(
      
      checkboxGroupInput(
        "products",
        "Select Products",
        choices = inventory$ProductName,
        selected = inventory$ProductName
      )
      
    ),
    
    mainPanel(
      
      fluidRow(
        
        column(
          6,
          plotOutput("barChart", height = "300px")
        ),
        
        column(
          6,
          plotOutput("stackChart", height = "300px")
        )
        
      ),
      
      hr(),
      
      h3("Inventory Data"),
      
      tableOutput("inventoryTable")
      
    )
    
  )
  
)

server <- function(input, output) {
  
  filtered <- reactive({
    inventory[inventory$ProductName %in% input$products, ]
  })
  
  # =====================================
  # Question 1 - Bar Chart
  # =====================================
  output$barChart <- renderPlot({
    
    data <- filtered()
    
    barplot(
      data$Quantity,
      names.arg = data$ProductName,
      col = "steelblue",
      xlab = "Product Name",
      ylab = "Quantity Available",
      main = "Quantity Available for Each Product"
    )
    
  })
  
  # =====================================
  # Question 2 - Stacked Bar Chart
  # =====================================
  output$stackChart <- renderPlot({
    
    data <- filtered()
    
    stack_data <- tapply(
      data$Quantity,
      list(data$Category, data$ProductName),
      sum
    )
    
    stack_data[is.na(stack_data)] <- 0
    
    barplot(
      stack_data,
      col = rainbow(nrow(stack_data)),
      main = "Stacked Bar Chart by Product Category",
      xlab = "Products",
      ylab = "Quantity",
      legend = rownames(stack_data)
    )
    
  })
  
  # =====================================
  # Question 3 - Table
  # =====================================
  output$inventoryTable <- renderTable({
    
    filtered()
    
  })
  
}

# =====================================
# Question 4 - Dashboard
# =====================================
shinyApp(ui = ui, server = server)