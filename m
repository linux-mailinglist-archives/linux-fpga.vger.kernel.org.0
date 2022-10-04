Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F75F45B5
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Oct 2022 16:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJDOh1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 Oct 2022 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJDOhT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 Oct 2022 10:37:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD161D5C;
        Tue,  4 Oct 2022 07:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664894231; x=1696430231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cRX0PJhJifPXtF4w0WrenhDhOGdQAeJkuWVJp+XRH7I=;
  b=WbeNhiN2Bi0w1KWXe9RXVDaqRsTIyiLCTos0nohUEKDBdPL3tI5tvC0n
   1ZPBhrltZCmi9MBsTc5N18dEgkB37aPKsPq00H5UjDOff2cXScn+KPwNp
   n7DjfPfW2f6EPRpSlMBFPQxiiWZ/suptmHvMzpOte/fU2UuiVRFshcMNc
   L+h+4V7OKRDzmgiekU/i+QlJb6jnWG0Co719JNvU5+hNpvPZPgy8+ys2R
   KtGrHNH3joGuUoa6cIAZwpk68Fr9JdqWUmsCfQ5K8rH7Gs/614dKKi/Fg
   Y9dSp7NtKdbNj42cSttyiLED6yhEvoaAnIM3NuQqB5cOpvsS8GpIgRKIr
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="389215875"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="389215875"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="869021638"
X-IronPort-AV: E=Sophos;i="5.95,158,1661842800"; 
   d="scan'208";a="869021638"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2022 07:37:05 -0700
From:   matthew.gerlach@linux.intel.com
To:     hao.wu@intel.com, yilun.xu@intel.com, russell.h.weight@intel.com,
        basheer.ahmed.muddebihal@intel.com, trix@redhat.com,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tianfei.zhang@intel.com, corbet@lwn.net,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com,
        niklas.soderlund+renesas@ragnatech.se, macro@orcam.me.uk,
        johan@kernel.org, lukas@wunner.de
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 4/4] tty: serial: 8250: add DFL bus driver for Altera 16550.
Date:   Tue,  4 Oct 2022 07:37:18 -0700
Message-Id: <20221004143718.1076710-5-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
References: <20221004143718.1076710-1-matthew.gerlach@linux.intel.com>
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
v3: use passed in location of registers
    use cleaned up functions for parsing parameters

v2: clean up error messages
    alphabetize header files
    fix 'missing prototype' error by making function static
    tried to sort Makefile and Kconfig better
---
 drivers/tty/serial/8250/8250_dfl.c | 177 +++++++++++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig    |   9 ++
 drivers/tty/serial/8250/Makefile   |   1 +
 3 files changed, 187 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_dfl.c

diff --git a/drivers/tty/serial/8250/8250_dfl.c b/drivers/tty/serial/8250/8250_dfl.c
new file mode 100644
index 000000000000..110ad3a73459
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
+	int line;
+};
+
+static int dfl_uart_get_params(struct device *dev, void __iomem *dfh_base, resource_size_t max,
+			       struct uart_8250_port *uart)
+{
+	u64 v, fifo_len, reg_width;
+	int off;
+
+	if (!dfhv1_has_params(dfh_base)) {
+		dev_err(dev, "missing required DFH parameters\n");
+		return -EINVAL;
+	}
+
+	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_CLK_FRQ);
+	if (off < 0) {
+		dev_err(dev, "missing CLK_FRQ param\n");
+		return -EINVAL;
+	}
+
+	uart->port.uartclk = readq(dfh_base + off);
+	dev_dbg(dev, "UART_CLK_ID %u Hz\n", uart->port.uartclk);
+
+	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_FIFO_LEN);
+	if (off < 0) {
+		dev_err(dev, "missing FIFO_LEN param\n");
+		return -EINVAL;
+	}
+
+	fifo_len = readq(dfh_base + off);
+	dev_dbg(dev, "UART_FIFO_ID fifo_len %llu\n", fifo_len);
+
+	switch (fifo_len) {
+	case 32:
+		uart->port.type = PORT_ALTR_16550_F32;
+		break;
+
+	case 64:
+		uart->port.type = PORT_ALTR_16550_F64;
+		break;
+
+	case 128:
+		uart->port.type = PORT_ALTR_16550_F128;
+		break;
+
+	default:
+		dev_err(dev, "bad fifo_len %llu\n", fifo_len);
+		return -EINVAL;
+	}
+
+	off = dfhv1_find_param(dfh_base, max, DFHv1_PARAM_ID_REG_LAYOUT);
+	if (off < 0) {
+		dev_err(dev, "missing REG_LAYOUT param\n");
+		return -EINVAL;
+	}
+
+	v = readq(dfh_base + off);
+	uart->port.regshift = FIELD_GET(DFHv1_PARAM_ID_REG_SHIFT, v);
+	reg_width = FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v);
+
+	dev_dbg(dev, "UART_LAYOUT_ID width %lld shift %d\n",
+		FIELD_GET(DFHv1_PARAM_ID_REG_WIDTH, v), (int)uart->port.regshift);
+
+	switch (reg_width) {
+	case 4:
+		uart->port.iotype = UPIO_MEM32;
+		break;
+
+	case 2:
+		uart->port.iotype = UPIO_MEM16;
+		break;
+
+	default:
+		dev_err(dev, "invalid reg_width %lld\n", reg_width);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int dfl_uart_probe(struct dfl_device *dfl_dev)
+{
+	struct device *dev = &dfl_dev->dev;
+	struct uart_8250_port uart;
+	struct dfl_uart *dfluart;
+	resource_size_t res_size;
+	void __iomem *dfh_base;
+	int ret;
+
+	memset(&uart, 0, sizeof(uart));
+	uart.port.flags = UPF_IOREMAP;
+	uart.port.mapbase = dfl_dev->csr_res.start;
+	uart.port.mapsize = resource_size(&dfl_dev->csr_res);
+
+	dfluart = devm_kzalloc(dev, sizeof(*dfluart), GFP_KERNEL);
+	if (!dfluart)
+		return -ENOMEM;
+
+	dfh_base = devm_ioremap_resource(dev, &dfl_dev->mmio_res);
+	if (IS_ERR(dfh_base))
+		return PTR_ERR(dfh_base);
+
+	res_size = resource_size(&dfl_dev->mmio_res);
+
+	ret = dfl_uart_get_params(dev, dfh_base, res_size, &uart);
+
+	devm_iounmap(dev, dfh_base);
+	devm_release_mem_region(dev, dfl_dev->mmio_res.start, res_size);
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed uart feature walk\n");
+
+	dev_dbg(dev, "nr_irqs %d %p\n", dfl_dev->num_irqs, dfl_dev->irqs);
+
+	if (dfl_dev->num_irqs == 1)
+		uart.port.irq = dfl_dev->irqs[0];
+
+	/* register the port */
+	dfluart->line = serial8250_register_8250_port(&uart);
+	if (dfluart->line < 0)
+		return dev_err_probe(dev, dfluart->line, "unable to register 8250 port.\n");
+
+	dev_info(dev, "serial8250_register_8250_port %d\n", dfluart->line);
+	dev_set_drvdata(dev, dfluart);
+
+	return 0;
+}
+
+static void dfl_uart_remove(struct dfl_device *dfl_dev)
+{
+	struct dfl_uart *dfluart = dev_get_drvdata(&dfl_dev->dev);
+
+	if (dfluart->line >= 0)
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
-- 
2.25.1

