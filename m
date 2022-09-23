Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35D55E7A9F
	for <lists+linux-fpga@lfdr.de>; Fri, 23 Sep 2022 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiIWMWq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 23 Sep 2022 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiIWMWA (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 23 Sep 2022 08:22:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F9C13506F;
        Fri, 23 Sep 2022 05:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663935453; x=1695471453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OllXRQtgPFGbhlCOhBzLOUg1JkZUATRFajkga5SoAg=;
  b=DVX5T65TzM6lnfbR20+5s2rbv/5Yhr4GfxcZiClQ06n8eZOprSJyKint
   w80hN9xZcVJ8whfjaEOzyVgCBVt21l4MhHMxIP/rAky1j88M2E4cbUJ7Q
   Z2XksVRQ6OBhDyMfTOEMC823dcLXWet7vHrwWy6WqHRakkBZa7nQuCfOF
   R7cr7jqKo04N9yZm5VEEhKFv117rn/4mN8L8hL2L0c38+FV2CrDUg/l6/
   L+BwmmpfRQbVC91ghI4Y6KQXAIm+lE8i+8Xl+q1MxpUjXl+M4Pc0zC12b
   o7yb1vJy+s+nJqDKUbN/vmwujm45LBh+JL2oNMMUUE0Xrd8UVL48OC3Ay
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="364595297"
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="364595297"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,339,1654585200"; 
   d="scan'208";a="762597753"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 05:17:33 -0700
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
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 6/6] tty: serial: 8250: add DFL bus driver for Altera 16550.
Date:   Fri, 23 Sep 2022 05:17:45 -0700
Message-Id: <20220923121745.129167-7-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
References: <20220923121745.129167-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add a Device Feature List (DFL) bus driver for the Altera
16550 implementation of UART.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reported-by: kernel test robot <lkp@intel.com>
---
v2: clean up error messages
    alphabetize header files
    fix 'missing prototype' error by making function static
    tried to sort Makefile and Kconfig better
---
 drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 include/linux/dfl.h                |   7 ++
 4 files changed, 194 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
new file mode 100644
index 000000000000..539ca6138eda
--- /dev/null
+++ b/drivers/tty/serial/8250/8250_dfl.c
@@ -0,0 +1,177 @@
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
+#include <linux/bitfield.h>
+#include <linux/dfl.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serial.h>
+#include <linux/serial_8250.h>
+
+struct dfl_uart {
+	void __iomem   *csr_base;
+	struct device  *dev;
+	u64             uart_clk;
+	u64             fifo_len;
+	unsigned int    fifo_size;
+	unsigned int    reg_shift;
+	unsigned int    line;
+};
+
+static int feature_uart_walk(struct dfl_uart *dfluart, resource_size_t max)
+{
+	void __iomem *param_base;
+	int off;
+	u64 v;
+
+	v = readq(dfluart->csr_base + DFHv1_CSR_SIZE_GRP);
+
+	if (!FIELD_GET(DFHv1_CSR_SIZE_GRP_HAS_PARAMS, v)) {
+		dev_err(dfluart->dev, "missing required DFH parameters\n");
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
+	dfluart->dev = dev;
+
+	dfluart->csr_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
+	if (IS_ERR(dfluart->csr_base)) {
+		return PTR_ERR(dfluart->csr_base);
+	}
+
+	ret = feature_uart_walk(dfluart, resource_size(&dfl_dev->mmio_res));
+
+	devm_iounmap(dev, dfluart->csr_base);
+	devm_release_mem_region(dev, dfl_dev->mmio_res.start, resource_size(&dfl_dev->mmio_res));
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed uart feature walk\n");
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
+	uart.port.mapbase = dfl_dev->csr_start;
+	uart.port.mapsize = dfl_dev->csr_size;
+	uart.port.regshift = dfluart->reg_shift;
+	uart.port.uartclk = dfluart->uart_clk;
+	uart.port.flags |= UPF_IOREMAP;
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
+MODULE_DEVICE_TABLE(dfl, dfl_uart_ids);
+
+static struct dfl_driver dfl_uart_driver = {
+	.drv = {
+		.name = "dfl-uart",
+	},
+	.id_table = dfl_uart_ids,
+	.probe = dfl_uart_probe,
+	.remove = dfl_uart_remove,
+};
+module_dfl_driver(dfl_uart_driver);
+
+MODULE_DESCRIPTION("DFL Intel UART driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index d0b49e15fbf5..5c6497ce5c12 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -361,6 +361,15 @@ config SERIAL_8250_BCM2835AUX
 
 	  If unsure, say N.
 
+config SERIAL_8250_DFL
+	tristate "DFL bus driver for Altera 16550 UART"
+	depends on SERIAL_8250 && FPGA_DFL
+	help
+	  This option enables support for a Device Feature List (DFL) bus
+	  driver for the Altera 16650 UART.  One or more Altera 16650 UARTs
+	  can be instantiated in a FPGA and then be discovered during
+	  enumeration of the DFL bus.
+
 config SERIAL_8250_FSL
 	bool "Freescale 16550 UART support" if COMPILE_TEST && !(PPC || ARM || ARM64)
 	depends on SERIAL_8250_CONSOLE
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index bee908f99ea0..32006e0982d1 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SERIAL_8250_CONSOLE)	+= 8250_early.o
 obj-$(CONFIG_SERIAL_8250_FOURPORT)	+= 8250_fourport.o
 obj-$(CONFIG_SERIAL_8250_ACCENT)	+= 8250_accent.o
 obj-$(CONFIG_SERIAL_8250_BOCA)		+= 8250_boca.o
+obj-$(CONFIG_SERIAL_8250_DFL)		+= 8250_dfl.o
 obj-$(CONFIG_SERIAL_8250_EXAR_ST16C554)	+= 8250_exar_st16c554.o
 obj-$(CONFIG_SERIAL_8250_HUB6)		+= 8250_hub6.o
 obj-$(CONFIG_SERIAL_8250_FSL)		+= 8250_fsl.o
diff --git a/include/linux/dfl.h b/include/linux/dfl.h
index 7d74ef8d1d20..a17aeccc501e 100644
--- a/include/linux/dfl.h
+++ b/include/linux/dfl.h
@@ -67,6 +67,13 @@
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

