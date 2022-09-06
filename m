Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529C85AF42F
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Sep 2022 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiIFTEd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Sep 2022 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIFTE2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Sep 2022 15:04:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC0C5FC5;
        Tue,  6 Sep 2022 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662491065; x=1694027065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4h0JM6qcQpNcuJbIMjN6NzwvS0Px/3uXm+mL2vyJxbU=;
  b=jpUIlgGqF84d0S027QP2G5+f7TicNKh4xK6bhs2PEz4mgbRmkTnXLJz8
   RdczD0UH+he3dYR5U0frAYfz6Th6Hlb3DZQus8QhUqGoacggv9vGmihzI
   FgucgZWNklX2M+YaoJXPDc6mbTcMcROZidDAw++/oJm6gJKC8CAgeBG5g
   MYJhhpSBXs/5kK9K1tPYTeSGTNJqhD21JM/F/3r1GvByM/pUk5/K/w55W
   2bVX4NfdLdbcUzrmK0WAP9dZKkCmo+dlFom62w1uDW/OMMw2b4wDAaXBC
   R+bvFCBBdtpiPYfO0162CsUIwVVbd526FTlXF5jXGDjEOWKh8paMmXtd2
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283677340"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283677340"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="789782554"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 12:04:18 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, phil.edworthy@renesas.com,
        macro@orcam.me.uk, johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: [PATCH v1 5/5] tty: serial: 8250: add DFL bus driver for Altera 16550.
Date:   Tue,  6 Sep 2022 12:04:26 -0700
Message-Id: <20220906190426.3139760-6-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
References: <20220906190426.3139760-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add a Device Feature List (DFL) bus driver for the Altera
16550 implementation of UART.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dfl.c | 188 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   7 ++
 4 files changed, 205 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
new file mode 100644
index 000000000000..dcf6638a298c
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for FPGA UART
+ *
+ * Copyright (C) 2022 Intel Corporation, Inc.
+ *
+ * Authors:
+ *   Ananda Ravuri <ananda.ravuri@intel.com>
+ *   Matthew Gerlach <matthew.gerlach@linux.intel.com>
+ */
+
+#include <linux/dfl.h>
+#include <linux/version.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/bitfield.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+
+struct dfl_uart {
+	void __iomem   *csr_base;
+	u64             csr_addr;
+	unsigned int    csr_size;
+	struct device  *dev;
+	u64             uart_clk;
+	u64             fifo_len;
+	unsigned int    fifo_size;
+	unsigned int    reg_shift;
+	unsigned int    line;
+};
+
+int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
+{
+	void __iomem *param_base;
+	int off;
+	u64 v;
+
+	v = readq(dfluart->csr_base + DFHv1_CSR_ADDR);
+	dfluart->csr_addr = FIELD_GET(DFHv1_CSR_ADDR_MASK, v);
+
+	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
+	dfluart->csr_size = FIELD_GET(DFHv1_CSR_SIZE_GRP_SIZE, v);
+
+	if (dfluart->csr_addr == 0 || dfluart->csr_size == 0) {
+		dev_err(dfluart->dev, "FIXME bad dfh address and size\n");
+		return -EINVAL;
+	}
+
+	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
+		dev_err(dfluart->dev, "missing required parameters\n");
+		return -EINVAL;
+	}
+
+	param_base = dfluart->csr_base + DFHv1_PARAM_HDR;
+
+	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_CLK_FRQ);
+	if (off < 0) {
+		dev_err(dfluart->dev, "missing CLK_FRQ param\n");
+		return -EINVAL;
+	}
+
+	dfluart->uart_clk = readq(param_base + off + DFHv1_PARAM_DATA);
+	dev_dbg(dfluart->dev, "UART_CLK_ID %llu Hz\n", dfluart->uart_clk);
+
+	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_FIFO_LEN);
+	if (off < 0) {
+		dev_err(dfluart->dev, "missing FIFO_LEN param\n");
+		return -EINVAL;
+	}
+
+	dfluart->fifo_len = readq(param_base + off + DFHv1_PARAM_DATA);
+	dev_dbg(dfluart->dev, "UART_FIFO_ID fifo_len %llu\n", dfluart->fifo_len);
+
+	off = dfl_find_param(param_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
+	if (off < 0) {
+		dev_err(dfluart->dev, "missing REG_LAYOUT param\n");
+		return -EINVAL;
+	}
+
+	v = readq(param_base + off + DFHv1_PARAM_DATA);
+	dfluart->fifo_size = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
+	dfluart->reg_shift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
+	dev_dbg(dfluart->dev, "UART_LAYOUT_ID width %d shift %d\n",
+		dfluart->fifo_size, dfluart->reg_shift);
+
+	return 0;
+}
+
+static int dfl_uart_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct uart_8250_port uart;
+	struct dfl_uart *dfluart;
+	int ret;
+
+	memset(&uart, 0, sizeof(uart));
+
+	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
+	if (!dfluart)
+		return -ENOMEM;
+
+	dfluart->csr_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
+	if (IS_ERR(dfluart->csr_base)) {
+		dev_err(dev, "failed to get mem resource!\n");
+		return PTR_ERR(dfluart->csr_base);
+	}
+
+	dfluart->dev = dev;
+
+	ret = feature_uart_walk(dfluart, resource_size(&dfl_dev->mmio_res));
+	if (ret < 0) {
+		dev_err(dev, "failed to uart feature walk %d\n", ret);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
+
+	if (dfl_dev->num_irqs == 1)
+		uart.port.irq = dfl_dev->irqs[0];
+
+	switch (dfluart->fifo_len) {
+	case 32:
+		uart.port.type = PORT_ALTR_16550_F32;
+		break;
+
+	case 64:
+		uart.port.type = PORT_ALTR_16550_F64;
+		break;
+
+	case 128:
+		uart.port.type = PORT_ALTR_16550_F128;
+		break;
+
+	default:
+		dev_err(dev, "bad fifo_len %llu\n", dfluart->fifo_len);
+		return -EINVAL;
+	}
+
+	uart.port.iotype = UPIO_MEM32;
+	uart.port.membase = dfluart->csr_base + dfluart->csr_addr;
+	uart.port.mapsize = dfluart->csr_size;
+	uart.port.regshift = dfluart->reg_shift;
+	uart.port.uartclk = dfluart->uart_clk;
+
+	/* register the port */
+	ret = serial8250_register_8250_port(&uart);
+	if (ret < 0) {
+		dev_err(dev, "unable to register 8250 port %d.\n", ret);
+		return -EINVAL;
+	}
+	dev_info(dev, "serial8250_register_8250_port %d\n", ret);
+	dfluart->line = ret;
+	dev_set_drvdata(dev, dfluart);
+
+	return 0;
+}
+
+static void dfl_uart_remove(struct dfl_device *dfl_dev)
+{
+	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
+
+	if (dfluart->line > 0)
+		serial8250_unregister_port(dfluart->line);
+}
+
+#define FME_FEATURE_ID_UART 0x24
+
+static const struct dfl_device_id dfl_uart_ids[] = {
+	{ FME_ID, FME_FEATURE_ID_UART },
+	{ }
+};
+
+static struct dfl_driver dfl_uart_driver = {
+	.drv = {
+		.name = "dfl-uart",
+	},
+	.id_table = dfl_uart_ids,
+	.probe = dfl_uart_probe,
+	.remove = dfl_uart_remove,
+};
+
+module_dfl_driver(dfl_uart_driver);
+
+MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
+MODULE_DESCRIPTION("DFL Intel UART driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..fbb59216ce7f 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -546,3 +546,12 @@ config SERIAL_OF_PLATFORM
 	  are probed through devicetree, including Open Firmware based
 	  PowerPC systems and embedded systems on architectures using the
 	  flattened device tree format.
+
+config SERIAL_8250_DFL
+	tristate "DFL bus driver for Altera 16550 UART"
+	depends on SERIAL_8250 && FPGA_DFL
+	help
+	  This option enables support for a Device Feature List (DFL) bus
+	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
+	  can be instantiated in a FPGA and then be discovered during
+	  enumeration of the DFL bus.
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..8e987b04820a 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -43,5 +43,6 @@ obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
 obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
 obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
 obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
+obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 
 CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 5652879ab48e..d37636090fed 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -73,6 +73,13 @@
 #define DFHv1_PARAM_MSIX_STARTV	0x8
 #define DFHv1_PARAM_MSIX_NUMV	0xc
 
+#define DFHv1_PARAM_ID_CLK_FRQ    0x2
+#define DFHv1_PARAM_ID_FIFO_LEN   0x3
+
+#define DFHv1_PARAM_ID_REG_LAYOUT 0x4
+#define DFHv1_PARAM_ID_REG_WIDTH  GENMASK_ULL(63, 32)
+#define DFHv1_PARAM_ID_REG_SHIFT  GENMASK_ULL(31, 0)
+
 /**
  * enum dfl_id_type - define the DFL FIU types
  */
-- 
2.25.1

