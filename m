Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1B3283D8C
	for <lists+linux-fpga@lfdr.de>; Mon,  5 Oct 2020 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgJERiO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Oct 2020 13:38:14 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:33453 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgJERhu (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Oct 2020 13:37:50 -0400
Received: by mail-pj1-f45.google.com with SMTP id t23so346919pji.0;
        Mon, 05 Oct 2020 10:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PJinqLCKTDe+aRSItigFp/wrvpdMWTGVdNBIcRnfBzA=;
        b=VE/0o6BDpOLu9ao59vZ3LCuk1IajfIR/w+lYnL2ZEi4wUdhWdfd9g+tRvr9pEs3OB8
         j/FY72XvaaKtRmSFk+8AFAu793nojdTGjv6gS6OwGVRWCPq0WjvHAGQqQ9bRBJWSkJHa
         64Pc2rgw2Ay2wj9+loPj+TM9y4q7yAN07sD6p7BkWNBgqDMS9Yt6znTC+fGxd7l7OJRb
         UB6KeIJt/GI9TytrIOPrLhyr7RcmG5m5xWtTAPEPYwDo48XCsHUEZP+xr+Lx9Km9vW5I
         OvwUxP/6ncjbCfnaySmMsD9lUqajwKXReCpKG5NJ+EO227emT7AgfoCYT8kOTMl8VIQJ
         +K+w==
X-Gm-Message-State: AOAM531c2uoVF/aEA8sZjaIym6OU6V3iMmeZz/Uy2GSWviLWl7ZcfFsV
        NhgcPp0+QqLDfoyonB9hdoNw3Ac83b8=
X-Google-Smtp-Source: ABdhPJwdvnEtZIDBh4qK3r1xDzccd0E4i+usLvtnb/8vdfe8iRjZfHrJt9UaCm9t4fceQLtH0RmFZA==
X-Received: by 2002:a17:90b:f8b:: with SMTP id ft11mr544364pjb.8.1601919469830;
        Mon, 05 Oct 2020 10:37:49 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id az18sm181250pjb.35.2020.10.05.10.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 10:37:49 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com,
        Moritz Fischer <mdf@kernel.org>
Subject: [PATCH v2 05/10] fpga: fpga-mgr: machxo2-spi: Simplify registration
Date:   Mon,  5 Oct 2020 10:37:30 -0700
Message-Id: <20201005173735.162408-6-mdf@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005173735.162408-1-mdf@kernel.org>
References: <20201005173735.162408-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Simplify registration using new devm_fpga_mgr_register() API.

Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/fpga/machxo2-spi.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
index b316369156fe..114a64d2b7a4 100644
--- a/drivers/fpga/machxo2-spi.c
+++ b/drivers/fpga/machxo2-spi.c
@@ -371,18 +371,7 @@ static int machxo2_spi_probe(struct spi_device *spi)
 	if (!mgr)
 		return -ENOMEM;
 
-	spi_set_drvdata(spi, mgr);
-
-	return fpga_mgr_register(mgr);
-}
-
-static int machxo2_spi_remove(struct spi_device *spi)
-{
-	struct fpga_manager *mgr = spi_get_drvdata(spi);
-
-	fpga_mgr_unregister(mgr);
-
-	return 0;
+	return devm_fpga_mgr_register(dev, mgr);
 }
 
 static const struct of_device_id of_match[] = {
@@ -403,7 +392,6 @@ static struct spi_driver machxo2_spi_driver = {
 		.of_match_table = of_match_ptr(of_match),
 	},
 	.probe = machxo2_spi_probe,
-	.remove = machxo2_spi_remove,
 	.id_table = lattice_ids,
 };
 
-- 
2.28.0

