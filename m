Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2A244B0D7
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Jun 2019 06:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfFSE0L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 Jun 2019 00:26:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43584 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFSE0K (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 19 Jun 2019 00:26:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so8879486pgv.10;
        Tue, 18 Jun 2019 21:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dbGllrGPx+AB7xYDZWRsiMxcNPPa7QATCKKPSd01l4=;
        b=Y8JnYnv1CCz/L30StP5B5PwTpvR3HDv+2l56eaf4pvk4TqTy/GZ6C1kWkgIWvWdnQr
         v/gEPJH1rZfOtvHV6BPU0vVNwdAV1ou5Nov/ZivvXFdyyZcIqbAJkLOvLhmLcfJdeQTO
         YklATA5Y6TTvXdbE8toF7POtQcFMRWHIuzhsgpDdZJgdtAc2zkcl9t5ucAOUfcPAcpAN
         5Q98L8BQZN9xyo23vgL1ph140+fq1sCzd2CZjLZ1Qfe9j9zo3ZDjis84VsKcRMTRkCy2
         ObOvvX56hI3Dqf/m3M3Ij5Z61ksoYgNliDNMSGPja5ZgoJhifW7TgOR6JB3S3LbALR2H
         ConQ==
X-Gm-Message-State: APjAAAVyHf8FrWI8ESV6Genymjb9NcJ6lCIea0u/CK8TczKvyv85cyaC
        QhIWRRj1Q/lJC+t16nysYBg=
X-Google-Smtp-Source: APXvYqyd4rQz/H5sxyX5SLLyMicpCAUuJkcJ58CJaqs0nHDBMIfdXzH4vlS8kCGaCLHCT+SvW/qbog==
X-Received: by 2002:a63:c5:: with SMTP id 188mr5948894pga.108.1560918369803;
        Tue, 18 Jun 2019 21:26:09 -0700 (PDT)
Received: from localhost ([2601:647:4700:b8cd:7726:b947:9a25:6e35])
        by smtp.gmail.com with ESMTPSA id i25sm16892548pfr.73.2019.06.18.21.26.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 21:26:09 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        atull@kernel.org, Enrico Weigelt <info@metux.net>,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/1] drivers: fpga: Kconfig: pedantic cleanups
Date:   Tue, 18 Jun 2019 21:24:39 -0700
Message-Id: <20190619042439.4705-2-mdf@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190619042439.4705-1-mdf@kernel.org>
References: <20190619042439.4705-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Enrico Weigelt <info@metux.net>

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt <info@metux.net>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 8072c195d831..474f304ec109 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -26,9 +26,9 @@ config FPGA_MGR_SOCFPGA_A10
 	  FPGA manager driver support for Altera Arria10 SoCFPGA.
 
 config ALTERA_PR_IP_CORE
-        tristate "Altera Partial Reconfiguration IP Core"
-        help
-          Core driver support for Altera Partial Reconfiguration IP component
+	tristate "Altera Partial Reconfiguration IP Core"
+	help
+	  Core driver support for Altera Partial Reconfiguration IP component
 
 config ALTERA_PR_IP_CORE_PLAT
 	tristate "Platform support of Altera Partial Reconfiguration IP Core"
-- 
2.22.0

