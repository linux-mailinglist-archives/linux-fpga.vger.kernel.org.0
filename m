Return-Path: <linux-fpga+bounces-737-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7A69886BC
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 16:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CF441C2143D
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2024 14:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313A74C14;
	Fri, 27 Sep 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETiZAzw8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9518B1A;
	Fri, 27 Sep 2024 14:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727446493; cv=none; b=TaHViEfMj+nxqMM+47EK2X7NrQMGxaw7lLlrNKGiJ0IQaxqglwKAWBhgcja5HrPlVX4WgkhnaiWD1Cge/3sdnGK9d1Kvy+WMg7SJl5UkoomOzEwNQro2FuRyO+3bRI9q5IV6JjjN7kyUAIYWSQ3hoXYY5Pgby0n7bkDsbqI/Rds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727446493; c=relaxed/simple;
	bh=lk3RhykLJngcEDVRXH/SDu1OOgxZLlk0DOm58JC78XU=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=av+SxBvF8budVOHtlMxNOcw+E8TVcVPmNzjgqAQTI9TQbxocIXTvx6h/p9ZRb3qlPn9yGudCtzxV39sQdjgTupYDCYHdN/xyY+NQ6GWHz/UpndSIgEEDQzZrM/J5RkF+pLp1qVbhudIzjHT+c9Hi/6bQZzR6MUNGjlZU1NKfHLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETiZAzw8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53959a88668so991049e87.2;
        Fri, 27 Sep 2024 07:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727446490; x=1728051290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C72TPhpbh5i3Zhaa7WL58puaC2zZDkgeX/W2cYZyPHk=;
        b=ETiZAzw80xkzAeeAIIukRnOhmChTD5ufbiHSQZWDrMi3p3rMnw3yETnilc5gOFsKYk
         0zI6ZgLS/86ISfl2UmHoM1ecR4DWSMGQy7cyGgw5O1KvSasxwTlWH6oesljxmX5a9noq
         BtgBqSroCdRyl38kYslKY8Abxy3EWJzCJye86AoF4+4kv+gL/NMxK3YIxREsGJJ8cIE6
         WWmynxG/QueC8YWjSwODD5dEpHQz1ar5a4jqXxF1L6asS8f/Pnlj1+8mguGnipOb4rSH
         Bvl9KOxP1TP/NyZDBZ/ZJrp7fxL5boaEjHqZCnujmu6+JQ+iwz89suE4FyKa3Pi6PdfW
         U8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727446490; x=1728051290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C72TPhpbh5i3Zhaa7WL58puaC2zZDkgeX/W2cYZyPHk=;
        b=jA9/Pj+CiHX+4FNjQQsL97Y1fM+/vh/mQH6EDDsf9tLks2PwamjXUNjUdq4UFYCvtf
         suLBxaapKNNEmFyNZJqdAP+sbU6uWvFHkUbIIMYcGi+liXM+6VcFF0nyjpPv34YDcKG9
         aVtem+oYOIEuSx8KwbkC27ro1YVnSmIqMghKAKV86cuH/6/KrKgQHd96gm/NQlu1kt6C
         Izix2WHB0Av0okOMG5wajtyjv/HlGSnVRFowrEo4DeSruZBl9zDlE3ZQd3TjJd4HJdB6
         Wqzss3ErRtWNa6aZ8yWd8GrM8JNpBQRYzGSTNQo53OcjTMkakAxcIiMt+SMM/KPjFf4S
         vwjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs/q74poTvFmA/Afx272tKDcW7SgROk3fad6GCvKlb9MvxWQotMa248h4B/kn4cU1NYawxAMDXHGz9@vger.kernel.org, AJvYcCV4OI9YHU//vcTCd8p5J9PygjD7z+X3ZpxB1IBr06/Rz2tDsCpVSDbZ5ZUfMOTrf/HKafVwaxcoeOTI1kZ9@vger.kernel.org, AJvYcCXdxtujOaLiTgbu8sxeq9nnyje91z5a7riQsrRungCSKj0xj7b/QsFwDPNiEuMYIuHMHTx+5yXfGjZIEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuS5NPNqXdLPsafkiczkpLhggXmRK2NMR59OtPWPKzp4HrxmB
	VsF5oOpZh0w1di/kVJa1Q0JvRWYZIpG9BZ8uvgqr4Yw1KZxVrWfrgnBXOXzd
X-Google-Smtp-Source: AGHT+IHQtsgZddhEas31MPYGzYur0N324IQ6rvA5FqFZTxyiZgn/59YkhLz1uPOEqsn2kCPJtNxxXQ==
X-Received: by 2002:a05:6512:3b0e:b0:52f:2ea:499f with SMTP id 2adb3069b0e04-5389fc46c96mr2566206e87.24.1727446489121;
        Fri, 27 Sep 2024 07:14:49 -0700 (PDT)
Received: from iris-Ian.fritz.box (p200300eb5f4f030052bd6081d2396adf.dip0.t-ipconnect.de. [2003:eb:5f4f:300:52bd:6081:d239:6adf])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c88248af00sm1184519a12.67.2024.09.27.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 07:14:48 -0700 (PDT)
From: iansdannapel@gmail.com
To: mdf@kernel.org,
	hao.wu@intel.com,
	yilun.xu@intel.com,
	trix@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	heiko.stuebner@cherry.de,
	rafal@milecki.pl,
	linus.walleij@linaro.org,
	iansdannapel@gmail.com,
	linux-fpga@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fpga: Add Efinix Trion & Titanium serial SPI programming driver
Date: Fri, 27 Sep 2024 16:14:42 +0200
Message-Id: <20240927141445.157234-1-iansdannapel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ian Dannapel <iansdannapel@gmail.com>

Add a new driver for loading binary firmware to volatile
configuration RAM using "SPI passive programming" on Efinix FPGAs.

Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
---
 drivers/fpga/Kconfig                    |  10 ++
 drivers/fpga/Makefile                   |   1 +
 drivers/fpga/efinix-trion-spi-passive.c | 211 ++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
 create mode 100644 drivers/fpga/efinix-trion-spi-passive.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 37b35f58f0df..eb1e44c4e3e0 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -83,6 +83,16 @@ config FPGA_MGR_XILINX_SPI
 	  FPGA manager driver support for Xilinx FPGA configuration
 	  over slave serial interface.
 
+config FPGA_MGR_EFINIX_SPI
+	tristate "Efinix FPGA configuration over SPI passive"
+	depends on SPI
+	help
+	  This option enables support for the FPGA manager driver to
+	  configure Efinix Trion and Titanium Series FPGAs over SPI
+	  using passive serial mode.
+	  Warning: Do not activate this if there are other SPI devices
+	  on the same bus as it might interfere with the transmission.
+
 config FPGA_MGR_ICE40_SPI
 	tristate "Lattice iCE40 SPI"
 	depends on OF && SPI
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index aeb89bb13517..1a95124ff847 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_CORE)	+= xilinx-core.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SELECTMAP)	+= xilinx-selectmap.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
+obj-$(CONFIG_FPGA_MGR_EFINIX_SPI)	+= efinix-trion-spi-passive.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
 obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
diff --git a/drivers/fpga/efinix-trion-spi-passive.c b/drivers/fpga/efinix-trion-spi-passive.c
new file mode 100644
index 000000000000..87ff645265ca
--- /dev/null
+++ b/drivers/fpga/efinix-trion-spi-passive.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Trion and Titanium Series FPGA SPI Passive Programming Driver
+ *
+ * Copyright (C) 2024 iris-GmbH infrared & intelligent sensors
+ *
+ * Ian Dannapel <iansdannapel@gmail.com>
+ *
+ * Manage Efinix FPGA firmware that is loaded over SPI using
+ * the serial configuration interface.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+#include <linux/sizes.h>
+
+struct efinix_spi_conf {
+	struct spi_device *spi;
+	struct gpio_desc *cdone;
+	struct gpio_desc *creset;
+	struct gpio_desc *cs;
+};
+
+static int efinix_spi_get_cdone_gpio(struct efinix_spi_conf *conf)
+{
+	int ret;
+
+	ret = gpiod_get_value(conf->cdone);
+	return ret;
+}
+
+static void efinix_spi_reset(struct efinix_spi_conf *conf)
+{
+	gpiod_set_value(conf->creset, 1);
+	/* wait tCRESET_N */
+	usleep_range(5, 15);
+	gpiod_set_value(conf->creset, 0);
+}
+
+static enum fpga_mgr_states efinix_spi_state(struct fpga_manager *mgr)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (conf->cdone && efinix_spi_get_cdone_gpio(conf) == 1)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static int efinix_spi_apply_clk_cycles(struct efinix_spi_conf *conf)
+{
+	char data[13] = {0};
+
+	return spi_write(conf->spi, data, sizeof(data));
+}
+
+static int efinix_spi_write_init(struct fpga_manager *mgr,
+				 struct fpga_image_info *info,
+				 const char *buf, size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+
+	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
+		dev_err(&mgr->dev, "Partial reconfiguration not supported\n");
+		return -EINVAL;
+	}
+
+	/* reset with chip select active */
+	gpiod_set_value(conf->cs, 1);
+	usleep_range(5, 15);
+	efinix_spi_reset(conf);
+
+	/* wait tDMIN */
+	usleep_range(100, 150);
+
+	return 0;
+}
+
+static int efinix_spi_write(struct fpga_manager *mgr, const char *buf,
+			    size_t count)
+{
+	struct efinix_spi_conf *conf = mgr->priv;
+	int ret;
+
+	ret = spi_write(conf->spi, buf, count);
+	if (ret) {
+		dev_err(&mgr->dev, "SPI error in firmware write: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
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
+	/* append at least 100 clock cycles */
+	efinix_spi_apply_clk_cycles(conf);
+
+	/* release chip select */
+	gpiod_set_value(conf->cs, 0);
+
+	if (conf->cdone) {
+		while (!expired) {
+			expired = time_after(jiffies, timeout);
+
+			done = efinix_spi_get_cdone_gpio(conf);
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
+	/* wait tUSER */
+	usleep_range(75, 125);
+
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
+	conf->creset = devm_gpiod_get(&spi->dev, "creset", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->creset))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->creset),
+				"Failed to get RESET gpio\n");
+
+	conf->cs = devm_gpiod_get(&spi->dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(conf->cs))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cs),
+				"Failed to get CHIP_SELECT gpio\n");
+
+	if (!(spi->mode & SPI_CPHA) || !(spi->mode & SPI_CPOL))
+		return dev_err_probe(&spi->dev, -EINVAL,
+				"Unsupported SPI mode, set CPHA and CPOL\n");
+
+	conf->cdone = devm_gpiod_get_optional(&spi->dev, "cdone", GPIOD_IN);
+	if (IS_ERR(conf->cdone))
+		return dev_err_probe(&spi->dev, PTR_ERR(conf->cdone),
+				"Failed to get CDONE gpio\n");
+
+	mgr = devm_fpga_mgr_register(&spi->dev,
+				"Efinix SPI Passive Programming FPGA Manager",
+					&efinix_spi_ops, conf);
+
+	return PTR_ERR_OR_ZERO(mgr);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id efinix_spi_of_match[] = {
+	{ .compatible = "efinix,trion-spi-passive", },
+	{ .compatible = "efinix,titanium-spi-passive", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, efinix_spi_of_match);
+#endif
+
+static const struct spi_device_id efinix_ids[] = {
+	{ "trion-spi-passive", 0 },
+	{ "titanium-spi-passive", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, efinix_ids);
+
+static struct spi_driver efinix_spi_passive_driver = {
+	.driver = {
+		.name = "efinix-fpga-spi-passive",
+		.of_match_table = of_match_ptr(efinix_spi_of_match),
+	},
+	.probe = efinix_spi_probe,
+	.id_table = efinix_ids,
+};
+
+module_spi_driver(efinix_spi_passive_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Ian Dannapel <iansdannapel@gmail.com>");
+MODULE_DESCRIPTION("Load Efinix FPGA firmware over SPI passive");
-- 
2.34.1


