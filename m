Return-Path: <linux-fpga+bounces-925-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024C9C2170
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Nov 2024 17:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F248C2863D3
	for <lists+linux-fpga@lfdr.de>; Fri,  8 Nov 2024 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7A41974FA;
	Fri,  8 Nov 2024 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cr/WDMrp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C138192D82
	for <linux-fpga@vger.kernel.org>; Fri,  8 Nov 2024 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081620; cv=none; b=fjmRAhdz2Su7ts6TVaeSGQx6cW/SpGyozu/99YIFr/31DqaW0PYgslxLOFZCuE2Qklmo/rvpVb83dVvrr+d6Mq7/CD7mfNXuVAhEF8ib0wu4HyTkRz++NJn53nkYD/hkZDxH4bFuCdhFbfCSEEi/Tus2F8RlacKu7Eh+eIwKu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081620; c=relaxed/simple;
	bh=7NSj1Xnr7F8hZakc4I1cptxHnT4br1O77NIOrZGUPrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GplaL0g95gtW91j7TAd4xfGk1or/cB4m6PCFmZGdb+4bP7H9SnPc5Kh2wJOEWYRUmY5alwJDuvzQ4U9H92A0EIMI5R7LVaGv97nwATPaF2KtNZFBTLVxd0BJiFVjdUuE611WYpHAlAsEAt6nj+0vjzJO1e//nZl9aTw+jE0cj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cr/WDMrp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539e59dadebso2923221e87.0
        for <linux-fpga@vger.kernel.org>; Fri, 08 Nov 2024 08:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731081614; x=1731686414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kkDL4V3veNmrOFZ36EaLQVd7h8aNi6xyItjOeEoF3Hc=;
        b=Cr/WDMrp7C3cyrre4ZC1HYznMAb7M+nFkx9UdwzUyY0bFMBJ6bGWHhXmdbmhhpks2Z
         6Vbx3OtZBQtD+jFTz+EfKvRP9mUf+Hsv8a75uZxrIOg4UOPbplDcZZAtytJO8soY3gKd
         vBB30+5J1kKYfzxtTjsuyq3edblWH/b54AiDy0aDbTydI9mdZ3bfTVnKmH6DbYqbvOpZ
         8AMCEpMpc01htqFpFrLc3jH7QhDqrHwacfuk5idWcEIq6QSmy/K8mrQCfeqzCEPD80Yf
         YvqMW3LxaXuP6ixI7tAlccxt1EaGmyAoUKw74CIc+qh7UijoHa2QuXRIRs1gW+7Q7NV8
         7/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081614; x=1731686414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkDL4V3veNmrOFZ36EaLQVd7h8aNi6xyItjOeEoF3Hc=;
        b=djUGVs/EkXXDVjDtu2FtkLAOnR3xyTC2w0knIhPjI4IC+8AMJqbvqh1huYX1setxbn
         eDpAtzBWz0kn59yfVyubkc/1uTvuRuPqVCWhOGdXHpZ5TbF/lwMSm2frAH/tfUFxzqKq
         ZLDGkihuXkHc1En9QPITrE1C8aWH4VNVoYK3V4Tmdi+ykUziTZ9EURwaE/T+1YH3c3Bi
         f7bDOIg9Z/zlQ4897e1hMqRtp37BCBlviONB0I7m1NhXuW/0drvOXNdr9u7MQe1oFWmJ
         XUMDMNfMqyzzFLp+lJV1YdG3wYQIbo13KHo0K+QXZesR4OE0tp3W2CaU8s+DavCYhI+I
         kPkw==
X-Forwarded-Encrypted: i=1; AJvYcCX8ENFfJW+tRNk6x/2QCM+IlbWwazPN/LPl2nRYmukzSRcJVZPHnU1gBy82ku+RQxxk9J5ATcrIs0iO@vger.kernel.org
X-Gm-Message-State: AOJu0Ywax+pmmQCSRr5m6Sj2Ks3pA/8ePFmdubv9Pu/WHoSQR7BW0DQu
	qIMQRqKoje4a/kKhIbCadAnjBjXiRMIQms2AKTQIzY1kBMYLmAR+O1qQvknVsAI=
X-Google-Smtp-Source: AGHT+IF1GeW+WC7Q16r4NHBxEApntyR/w05a6dDXnUjlFn7jS5K3ZNUVOcfZh/J7IDBzWR2aecdCWg==
X-Received: by 2002:a05:6512:220c:b0:539:fb56:7790 with SMTP id 2adb3069b0e04-53d862bd3f7mr1968204e87.6.1731081613950;
        Fri, 08 Nov 2024 08:00:13 -0800 (PST)
Received: from localhost (p509159f1.dip0.t-ipconnect.de. [80.145.89.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9707bdsm5428190f8f.4.2024.11.08.08.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 08:00:13 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>
Cc: Tom Rix <trix@redhat.com>,
	Peter Colberg <peter.colberg@intel.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] fpga: Switch back to struct platform_driver::remove()
Date: Fri,  8 Nov 2024 17:00:02 +0100
Message-ID: <20241108160002.252517-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9458; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=7NSj1Xnr7F8hZakc4I1cptxHnT4br1O77NIOrZGUPrg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnLjWCBeU4r1G+IEQo4FqPzhxX2JrbCs447bwK6 etS4pFQD1aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZy41ggAKCRCPgPtYfRL+ TuFJB/9oOEA8Psx+30w1wER1hN8f80tN1wxqwEd9mBGDjMlOIRwMWmAV3R2MKJ6HaJK6Ups/2my DKg52Zq406dvxGMCpZCo3KVkacXS6wV3lNL0UkyfNVizMx4AveaMmYCgfXQGnR7m0taoVvabdOy vu8KgQb9gvudKTEGQ32l2pWryyHo0997SveUJK2OfpVBdJIYwjoBfQPvOdPlBf5/6DDupVMgJKc 3Df4Bnkxz1iEeY5zIJqaAcsbc3FjN9EkQaHO9tTzdn9+CBiwYSPao6X+z5KYdNbb9ExhkWbmF9w p+6WIRqrA44J444Q5V1h2Y4jt7qjUn0IF+f03iLQU8E/reQY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
return void") .remove() is (again) the right callback to implement for
platform drivers.

Convert all platform drivers below drivers/fpga to use .remove(), with
the eventual goal to drop struct platform_driver::remove_new(). As
.remove() and .remove_new() have the same prototypes, conversion is done
by just changing the structure member name in the driver initializer.

A few white space changes are included to make indention consistent.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

I did a single patch for all of drivers/fpga. While I usually prefer
to do one logical change per patch, this seems to be overengineering
here as the individual changes are really trivial and shouldn't be much
in the way for stable backports. But I'll happily split the patch if you
prefer it split. Also if you object the indentation stuff, I can rework
that.

This is based on today's next, if conflicts arise when you apply it
at some later time and don't want to resolve them, feel free to just
drop the changes to the conflicting files. I'll notice and followup at a
later time then. Or ask me for a fixed resend. (Having said that, I
recommend b4 am -3 + git am -3 which should resolve most conflicts just
fine.)

Best regards
Uwe

 drivers/fpga/altera-fpga2sdram.c        | 2 +-
 drivers/fpga/altera-freeze-bridge.c     | 2 +-
 drivers/fpga/altera-hps2fpga.c          | 2 +-
 drivers/fpga/dfl-afu-main.c             | 8 ++++----
 drivers/fpga/dfl-fme-br.c               | 8 ++++----
 drivers/fpga/dfl-fme-main.c             | 8 ++++----
 drivers/fpga/dfl-fme-region.c           | 8 ++++----
 drivers/fpga/intel-m10-bmc-sec-update.c | 2 +-
 drivers/fpga/of-fpga-region.c           | 2 +-
 drivers/fpga/socfpga-a10.c              | 2 +-
 drivers/fpga/stratix10-soc.c            | 2 +-
 drivers/fpga/xilinx-pr-decoupler.c      | 2 +-
 drivers/fpga/zynq-fpga.c                | 2 +-
 13 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
index f4de3fea0b2d..e41492988dd6 100644
--- a/drivers/fpga/altera-fpga2sdram.c
+++ b/drivers/fpga/altera-fpga2sdram.c
@@ -152,7 +152,7 @@ MODULE_DEVICE_TABLE(of, altera_fpga_of_match);
 
 static struct platform_driver altera_fpga_driver = {
 	.probe = alt_fpga_bridge_probe,
-	.remove_new = alt_fpga_bridge_remove,
+	.remove = alt_fpga_bridge_remove,
 	.driver = {
 		.name	= "altera_fpga2sdram_bridge",
 		.of_match_table = of_match_ptr(altera_fpga_of_match),
diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
index 44061cb16f87..594693ff786e 100644
--- a/drivers/fpga/altera-freeze-bridge.c
+++ b/drivers/fpga/altera-freeze-bridge.c
@@ -262,7 +262,7 @@ static void altera_freeze_br_remove(struct platform_device *pdev)
 
 static struct platform_driver altera_freeze_br_driver = {
 	.probe = altera_freeze_br_probe,
-	.remove_new = altera_freeze_br_remove,
+	.remove = altera_freeze_br_remove,
 	.driver = {
 		.name	= "altera_freeze_br",
 		.of_match_table = altera_freeze_br_of_match,
diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index 6f8e24be19c6..f2f1250689cb 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -205,7 +205,7 @@ MODULE_DEVICE_TABLE(of, altera_fpga_of_match);
 
 static struct platform_driver alt_fpga_bridge_driver = {
 	.probe = alt_fpga_bridge_probe,
-	.remove_new = alt_fpga_bridge_remove,
+	.remove = alt_fpga_bridge_remove,
 	.driver = {
 		.name	= "altera_hps2fpga_bridge",
 		.of_match_table = of_match_ptr(altera_fpga_of_match),
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 6b97c073849e..2fd4f07ed081 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -947,12 +947,12 @@ static const struct attribute_group *afu_dev_groups[] = {
 };
 
 static struct platform_driver afu_driver = {
-	.driver	= {
-		.name	    = DFL_FPGA_FEATURE_DEV_PORT,
+	.driver = {
+		.name = DFL_FPGA_FEATURE_DEV_PORT,
 		.dev_groups = afu_dev_groups,
 	},
-	.probe   = afu_probe,
-	.remove_new = afu_remove,
+	.probe = afu_probe,
+	.remove = afu_remove,
 };
 
 static int __init afu_init(void)
diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
index 0b01b3895277..950c606c59d4 100644
--- a/drivers/fpga/dfl-fme-br.c
+++ b/drivers/fpga/dfl-fme-br.c
@@ -92,11 +92,11 @@ static void fme_br_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver fme_br_driver = {
-	.driver	= {
-		.name    = DFL_FPGA_FME_BRIDGE,
+	.driver = {
+		.name = DFL_FPGA_FME_BRIDGE,
 	},
-	.probe   = fme_br_probe,
-	.remove_new = fme_br_remove,
+	.probe = fme_br_probe,
+	.remove = fme_br_remove,
 };
 
 module_platform_driver(fme_br_driver);
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 864924f68f5e..f8d89a4a6ccb 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -742,12 +742,12 @@ static const struct attribute_group *fme_dev_groups[] = {
 };
 
 static struct platform_driver fme_driver = {
-	.driver	= {
-		.name       = DFL_FPGA_FEATURE_DEV_FME,
+	.driver = {
+		.name = DFL_FPGA_FEATURE_DEV_FME,
 		.dev_groups = fme_dev_groups,
 	},
-	.probe   = fme_probe,
-	.remove_new = fme_remove,
+	.probe = fme_probe,
+	.remove = fme_remove,
 };
 
 module_platform_driver(fme_driver);
diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
index 71616f8b4982..c6cd63063c82 100644
--- a/drivers/fpga/dfl-fme-region.c
+++ b/drivers/fpga/dfl-fme-region.c
@@ -71,11 +71,11 @@ static void fme_region_remove(struct platform_device *pdev)
 }
 
 static struct platform_driver fme_region_driver = {
-	.driver	= {
-		.name    = DFL_FPGA_FME_REGION,
+	.driver = {
+		.name = DFL_FPGA_FME_REGION,
 	},
-	.probe   = fme_region_probe,
-	.remove_new = fme_region_remove,
+	.probe = fme_region_probe,
+	.remove = fme_region_remove,
 };
 
 module_platform_driver(fme_region_driver);
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 7ac9f9f5af12..dd515083bbdd 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -759,7 +759,7 @@ MODULE_DEVICE_TABLE(platform, intel_m10bmc_sec_ids);
 
 static struct platform_driver intel_m10bmc_sec_driver = {
 	.probe = m10bmc_sec_probe,
-	.remove_new = m10bmc_sec_remove,
+	.remove = m10bmc_sec_remove,
 	.driver = {
 		.name = "intel-m10bmc-sec-update",
 		.dev_groups = m10bmc_sec_attr_groups,
diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
index 8526a5a86f0c..43db4bb77138 100644
--- a/drivers/fpga/of-fpga-region.c
+++ b/drivers/fpga/of-fpga-region.c
@@ -436,7 +436,7 @@ static void of_fpga_region_remove(struct platform_device *pdev)
 
 static struct platform_driver of_fpga_region_driver = {
 	.probe = of_fpga_region_probe,
-	.remove_new = of_fpga_region_remove,
+	.remove = of_fpga_region_remove,
 	.driver = {
 		.name	= "of-fpga-region",
 		.of_match_table = of_match_ptr(fpga_region_of_match),
diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
index 4c03513b8f03..0165a3c86932 100644
--- a/drivers/fpga/socfpga-a10.c
+++ b/drivers/fpga/socfpga-a10.c
@@ -535,7 +535,7 @@ MODULE_DEVICE_TABLE(of, socfpga_a10_fpga_of_match);
 
 static struct platform_driver socfpga_a10_fpga_driver = {
 	.probe = socfpga_a10_fpga_probe,
-	.remove_new = socfpga_a10_fpga_remove,
+	.remove = socfpga_a10_fpga_remove,
 	.driver = {
 		.name	= "socfpga_a10_fpga_manager",
 		.of_match_table = socfpga_a10_fpga_of_match,
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index 2c0def7d7cbb..0a295ccf1644 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -455,7 +455,7 @@ MODULE_DEVICE_TABLE(of, s10_of_match);
 
 static struct platform_driver s10_driver = {
 	.probe = s10_probe,
-	.remove_new = s10_remove,
+	.remove = s10_remove,
 	.driver = {
 		.name	= "Stratix10 SoC FPGA manager",
 		.of_match_table = of_match_ptr(s10_of_match),
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 788dd2f63a65..822751fad18a 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -162,7 +162,7 @@ static void xlnx_pr_decoupler_remove(struct platform_device *pdev)
 
 static struct platform_driver xlnx_pr_decoupler_driver = {
 	.probe = xlnx_pr_decoupler_probe,
-	.remove_new = xlnx_pr_decoupler_remove,
+	.remove = xlnx_pr_decoupler_remove,
 	.driver = {
 		.name = "xlnx_pr_decoupler",
 		.of_match_table = xlnx_pr_decoupler_of_match,
diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
index 4db3d80e10b0..f7e08f7ea9ef 100644
--- a/drivers/fpga/zynq-fpga.c
+++ b/drivers/fpga/zynq-fpga.c
@@ -642,7 +642,7 @@ MODULE_DEVICE_TABLE(of, zynq_fpga_of_match);
 
 static struct platform_driver zynq_fpga_driver = {
 	.probe = zynq_fpga_probe,
-	.remove_new = zynq_fpga_remove,
+	.remove = zynq_fpga_remove,
 	.driver = {
 		.name = "zynq_fpga_manager",
 		.of_match_table = of_match_ptr(zynq_fpga_of_match),

base-commit: 929beafbe7acce3267c06115e13e03ff6e50548a
-- 
2.45.2


