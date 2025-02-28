Return-Path: <linux-fpga+bounces-1070-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26233A495BF
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 10:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7524116A3A3
	for <lists+linux-fpga@lfdr.de>; Fri, 28 Feb 2025 09:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A02825B67E;
	Fri, 28 Feb 2025 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfyBP75x"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9296C25B68B;
	Fri, 28 Feb 2025 09:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736071; cv=none; b=CHaR3bsls/XmT7S4efoAg4I/4iV6WeKzSzqimtctCejrrvsgkqFbavIdUeTVmhiSGbtidQE7dCE03PFW6q0z2jPLYfrgYIoHobNSRqrKxHzGTfE1Zhca88Ae81AUJ0DUGgmPRO42uhHX85GqTyg+M4jPxyiMwaTMiDdhBN8u8So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736071; c=relaxed/simple;
	bh=7FGp6HMCUmxSCnWSYcOxuQ2xsyHvUdjd1qcuXfLe9a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLmtylSH+ypYMZB1yAbg9lkEfGi6YHvDHpK6ebwiqWFGrzGjo8ZODMZZsBzLgwmMtDd3KNIjGY/jpuX0bCpXSHQowfqd1zcm9GX/ojKAlS2FjQfbNZlYSWQpaJo0zwQ8wIe6NVa4KsS/KVStK6Fteg5LO3MQq5GLZ9YbXOWt5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfyBP75x; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb9709b5b5so350544766b.2;
        Fri, 28 Feb 2025 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740736067; x=1741340867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CC3X3WegMCF3+xNDBiNQn+hWg2R0t6GnIVy+sJhsjfw=;
        b=GfyBP75xYqGv3nSJlYDwSwlxoPibQDGwajP9JfwhCixuoO0duCtnpO1spqOlb1F8Dr
         Nkzn99D8SeXOn3vhlkasaY4BW5DAr5nv8LtDf/SKsoOuyDIN8dkyeUFewNM4yMBMTmUC
         d+ZG+2i5RClU/oNy7orAkD+hfFRL9W8h9t6t9pjUBNcjIpm8iUSFw58LTXLst+H5SJz6
         BhnCubeqCShsTBS5EyawSlTqQZklxWCLD4ciYRBTD0ffWbnIGT7lQyIWhcLCdOT1kFJ3
         yYAK7ue29uZ+vO6yarFneMKcMhVmTufv2cir0RQNqSl4xFhIdmOvr0PpF6lcDRdegBbm
         TFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740736067; x=1741340867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CC3X3WegMCF3+xNDBiNQn+hWg2R0t6GnIVy+sJhsjfw=;
        b=Dfgn4qQPHOOgj/UkZQWjqx28b8KQaue5zjpYTcWVztpoeEHxzoEm79Kw+nx/lFUx4q
         wrzq4XxEroUax8dAjCkCudM96ZZf/4z/t6A6B/USkPzNL4gZLHofzd1LecJXOxGcL/Hd
         0tNFrf2bj34tDID7vqUznCCIYVnL2IU11cI3K0uNtpVNEwHKRMpELOvmWKm+RUCVOzV5
         P3PQVP9kESgM3wvqm6lOg/z8bBkVsOyVJBA6p04Fy+N8JFBJT7G+rVxtZ4SgSgvv7DHO
         vQwY9AR9xdSijuTVMYg6I9faHecN9nPys8NvTMkEgC8GkY0zc59YYm9TYNLbdPfU2HsC
         qt9g==
X-Forwarded-Encrypted: i=1; AJvYcCVz8X0QxYNlK1dfQJ3dSbz6h//59nAZoOtGfhtB50CrLv8xN0DBgGbowY8/iuGQtQitCF8nkUDqcMZ7@vger.kernel.org, AJvYcCVzcZYk/N5qLj8nDMiATQ48+zWs8gZxZ67ZHvXrkQdtQR+NjCvVcn/wsHBUwNz8jK3SrNaeF0kt3n4TDyG9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r8DvmbZFDinYudEk1wVkN6NiS7Cm0eAjqM8tTJACYkYbjKWe
	s4jfalrcfCfFcQsyUvunHDNDasqakFGKpAhV4NF2EhDXTuk9Gz2NhaNi6blU
X-Gm-Gg: ASbGncud03SetDrBRS2g/xX0+FZOQ2QVrZedADjT9cWUcR5z9E1RVubCtefctEbMxCl
	CZIsDkQrzyWzLsUEx6gaYcozy9+QEOYzMmqgJ3UKiKeZOaHUNoviVCzY+jln1kkZ04lPxRSryu3
	vxCYkXA84zXkLLlhEYA1gueDxw3g71YDqMvVBuENTI6Mc8nXdBBi638uPbkcfVTFNRjS5MegSRP
	rih+IlHCIxlv4EicpOuTwjqxDcSHGhIP24dGfMH5/al/yMQp1K2yQSgiSecf4+l+M3e3DdzNH60
	BUsp4QKOn4a3O0qo48pfYGkZD3F+93D1rnp3oJs/Lj2hp0A5TqUuYSHy0q+q3+G3EVqUIwf+yjk
	ECstu7z7po+d/mEC5mvWZwA==
X-Google-Smtp-Source: AGHT+IEAqDNi5XLg1A4Au9QSTTEA9q9YKZkFGrzQO01PgyrtK/RSkCJ5291OoTt1Kcu+PaKFKal8Cg==
X-Received: by 2002:a17:907:3e0b:b0:ab7:c152:a3ca with SMTP id a640c23a62f3a-abf25da2688mr228499866b.6.1740736066988;
        Fri, 28 Feb 2025 01:47:46 -0800 (PST)
Received: from iris-Ian.fritz.box (p200300eb5f0300004dcedf2362c26f55.dip0.t-ipconnect.de. [2003:eb:5f03:0:4dce:df23:62c2:6f55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf1a60de5esm209289566b.100.2025.02.28.01.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 01:47:46 -0800 (PST)
From: iansdannapel@gmail.com
To: linux-fpga@vger.kernel.org
Cc: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Ian Dannapel <iansdannapel@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
Date: Fri, 28 Feb 2025 10:47:32 +0100
Message-ID: <20250228094732.54642-4-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228094732.54642-1-iansdannapel@gmail.com>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add a new driver for loading binary firmware to configuration
RAM using "SPI passive mode" on Efinix FPGAs.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 drivers/fpga/Kconfig      |   7 ++
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/efinix-spi.c | 212 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)
 create mode 100644 drivers/fpga/efinix-spi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..b5d60ba62900 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -83,6 +83,13 @@ config FPGA_MGR_XILINX_SPI
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
 
+config FPGA_MGR_EFINIX_SPI
+	tristate "Efinix FPGA configuration over SPI"
+	depends on SPI
+	help
+	  FPGA manager driver support for Efinix FPGAs configuration over SPI
+	  (passive mode only).
+
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..adbd51d2cd1e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
diff --git a/drivers/fpga/efinix-spi.c b/drivers/fpga/efinix-spi.c
new file mode 100644
index 000000000000..07885110a8a8
--- /dev/null
+++ b/drivers/fpga/efinix-spi.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * FPGA Manager Driver for Efinix
+ *
+ * Copyright (C) 2025 iris-GmbH infrared & intelligent sensors
+ *
+ * Ian Dannapel <iansdannapel@gmail.com>
+ *
+ * Load Efinix FPGA firmware over SPI using the serial configuration interface.
+ *
+ * Note 1: Only passive mode (host initiates transfer) is currently supported.
+ * Note 2: Topaz and Titanium support is based on documentation but remains
+ * untested.
+ */
+
+#include <linux/delay.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+struct efinix_spi_conf {
+	struct spi_device *spi;
+	struct gpio_desc *cdone;
+	struct gpio_desc *reset;
+};
+
+static void efinix_spi_reset(struct efinix_spi_conf *conf)
+{
+	gpiod_set_value(conf->reset, 1);
+	/* tCRESET_N > 320 ns */
+	usleep_range(1, 2);
+	gpiod_set_value(conf->reset, 0);
+
+	/* tDMIN > 32 us */
+	usleep_range(35, 40);
+}
+
+static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (conf->cdone && gpiod_get_value(conf->cdone) == 1)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int efinix_spi_write_init(struct fpga_manager *mgr,
+				 struct fpga_image_info *info,
+				 const char *buf, size_t count)
+{
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
+			    size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret;
+	struct spi_message message;
+	struct spi_transfer assert_cs = {
+		.cs_change = 1
+	};
+	struct spi_transfer write_xfer = {
+		.tx_buf = buf,
+		.len = count
+	};
+	struct spi_transfer clk_cycles = {
+		.len = 13,  // > 100 clock cycles
+		.tx_buf = NULL
+	};
+	u8 *dummy_buf;
+
+	dummy_buf = kzalloc(13, GFP_KERNEL);
+	if (!dummy_buf) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	spi_bus_lock(conf->spi->controller);
+	spi_message_init(&message);
+	spi_message_add_tail(&assert_cs, &message);
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret)
+		goto fail_unlock;
+
+	/* reset with asserted cs */
+	efinix_spi_reset(conf);
+
+	spi_message_init(&message);
+	spi_message_add_tail(&write_xfer, &message);
+
+	clk_cycles.tx_buf = dummy_buf;
+	spi_message_add_tail(&clk_cycles, &message);
+
+	ret = spi_sync_locked(conf->spi, &message);
+	if (ret)
+		dev_err(&mgr->dev, "SPI error in firmware write: %d\n", ret);
+
+fail_unlock:
+	spi_bus_unlock(conf->spi->controller);
+	kfree(dummy_buf);
+fail:
+	return ret;
+}
+
+static int efinix_spi_write_complete(struct fpga_manager *mgr,
+				     struct fpga_image_info *info)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	unsigned long timeout =
+		jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
+	bool expired = false;
+	int done;
+
+	if (conf->cdone) {
+		while (!expired) {
+			expired = time_after(jiffies, timeout);
+
+			done = gpiod_get_value(conf->cdone);
+			if (done < 0)
+				return done;
+
+			if (done)
+				break;
+		}
+	}
+
+	if (expired)
+		return -ETIMEDOUT;
+
+	/* tUSER > 25 us */
+	usleep_range(30, 35);
+	return 0;
+}
+
+static const struct fpga_manager_ops efinix_spi_ops = {
+	.state = efinix_spi_state,
+	.write_init = efinix_spi_write_init,
+	.write = efinix_spi_write,
+	.write_complete = efinix_spi_write_complete,
+};
+
+static int efinix_spi_probe(struct spi_device *spi)
+{
+	struct efinix_spi_conf *conf;
+	struct fpga_manager *mgr;
+
+	conf = devm_kzalloc(&spi->dev, sizeof(*conf), GFP_KERNEL);
+	if (!conf)
+		return -ENOMEM;
+
+	conf->spi = spi;
+
+	conf->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->reset))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->reset),
+				     "Failed to get RESET gpio\n");
+
+	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				     "Unsupported SPI mode, set CPHA and CPOL\n");
+
+	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
+	if (IS_ERR(conf->cdone))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
+				     "Failed to get CDONE gpio\n");
+
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				     "Efinix FPGA Manager",
+				     &efinix_spi_ops, conf);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+static const struct of_device_id efinix_spi_of_match[] = {
+	{ .compatible = "efinix,trion-spi", },
+	{ .compatible = "efinix,titanium-spi", },
+	{ .compatible = "efinix,topaz-spi", },
+	{ .compatible = "efinix,fpga-spi", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
+
+static const struct spi_device_id efinix_ids[] = {
+	{ "trion-spi", 0 },
+	{ "titanium-spi", 0 },
+	{ "topaz-spi", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, efinix_ids);
+
+static struct spi_driver efinix_spi_driver = {
+	.driver = {
+		.name = "efinix-spi",
+		.of_match_table = efinix_spi_of_match,
+	},
+	.probe = efinix_spi_probe,
+	.id_table = efinix_ids,
+};
+
+module_spi_driver(efinix_spi_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
+MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver (Topaz/Titanium untested)");
-- 
2.43.0


