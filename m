Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75DB23B2040
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhFWS1L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 23 Jun 2021 14:27:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26980 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229933AbhFWS07 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 23 Jun 2021 14:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624472680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rfUUvCPY/yCW3nF5S1XXaaySwkjQfz2Hdett2DoZIxY=;
        b=HOFejhBbOnZy+/+rNaIrdqiTgWi42ooUIMP+RWMzaV+rhEoZ91GZMc5EPfcSVgucOrOII8
        G9KPS2RFQQlsPUdwmxLnpVrwNhSs3d571TkyhP1JD3UW+fPC2QtPCyUJdSWX6ExDCz4OwV
        Wl6TOcaSJHo3ndh7KY84D9f3T+HUO8Q=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-sbG9gL93MPScyndbqmWp8Q-1; Wed, 23 Jun 2021 14:24:39 -0400
X-MC-Unique: sbG9gL93MPScyndbqmWp8Q-1
Received: by mail-ot1-f70.google.com with SMTP id w5-20020a0568304105b0290456b49b7526so1807772ott.16
        for <linux-fpga@vger.kernel.org>; Wed, 23 Jun 2021 11:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfUUvCPY/yCW3nF5S1XXaaySwkjQfz2Hdett2DoZIxY=;
        b=STAT4msxq16SsOZ64/7FoktExpJavjt+97/SWoXtUG+ZeBFbeYKkqETcrZKTlmCVAX
         a/2y/mZzc+rBTqoRuTjDB189uGxx9ERA8qXSWrU0FqZ/ZTdvn7rhAhs9+DYZH5vmRjAw
         Myc0ZLjtduzD+7XS33rFpVNcMCYEmSTEIr0aVcAOyAtGpOKBbY/unH3BBM5Tld5RCw1w
         2D0Bwdbq1McznygFkFcchPTnLE/K9tGGMTXA2ABk6RbFD3QRw1n4SB6D/TkIphVlg71S
         9nI9zMxeu+IyP1d/lIv4bLWWGDsE7FPx/Cfcp/oS/JHa/NkJWhJpIMNV+yMHqx/QJB0A
         0h2Q==
X-Gm-Message-State: AOAM531yRjO4wrTfafQ3bgZZFX0LxXg3wGqKggbn2UpCwpUxz1qXXZ1I
        jLAc3SFOYxrhPLJ5DhJb39QKyDJI1ArRiKoVqtifWcLfV+8IkBU0t76na9cm6v9FqHMxzkGTzgr
        la/z0DnMlNai5adurgbPFNw==
X-Received: by 2002:a05:6830:33ea:: with SMTP id i10mr1095416otu.342.1624472678446;
        Wed, 23 Jun 2021 11:24:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwR7yevscaTjSXDf/VKL6RCgn8jGzo+VVZs7d7rmrj54N3eCdj0y/Xdcw5y6jjNgsqzE+WPlw==
X-Received: by 2002:a05:6830:33ea:: with SMTP id i10mr1095404otu.342.1624472678312;
        Wed, 23 Jun 2021 11:24:38 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l24sm105186oii.45.2021.06.23.11.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 11:24:37 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v3 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Wed, 23 Jun 2021 11:24:09 -0700
Message-Id: <20210623182410.3787784-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623182410.3787784-1-trix@redhat.com>
References: <20210623182410.3787784-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a fpga_remove() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 7d50ce26bf00c..1a2b8d8be7674 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -731,6 +731,12 @@ int fpga_mgr_register(struct fpga_manager *mgr)
 }
 EXPORT_SYMBOL_GPL(fpga_mgr_register);
 
+static void fpga_mgr_fpga_remove(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->fpga_remove)
+		mgr->mops->fpga_remove(mgr);
+}
+
 /**
  * fpga_mgr_unregister - unregister an FPGA manager
  * @mgr: fpga manager struct
@@ -745,8 +751,7 @@ void fpga_mgr_unregister(struct fpga_manager *mgr)
 	 * If the low level driver provides a method for putting fpga into
 	 * a desired state upon unregister, do it.
 	 */
-	if (mgr->mops->fpga_remove)
-		mgr->mops->fpga_remove(mgr);
+	fpga_mgr_fpga_remove(mgr);
 
 	device_unregister(&mgr->dev);
 }
-- 
2.26.3

