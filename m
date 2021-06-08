Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1023A04B7
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbhFHT5Y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234633AbhFHT5N (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=htxg7QFhlugIkUjEBRB6MmryeZkakMXu7uhWLDq62MQ=;
        b=fIySp3vH0eSj3hCLDeYg3V5APorNcyGv7OPMKijN9YBj/ZCjr+19w62vtiDi/yxEYJhirb
        RQyqmJxVyeBSm1mFJsEymmbXEzKAMs5ZtzrnDw9l5WVPKkGGli/x6ltdal2gNa5NREBMmF
        NXwIOMaQHB/fqLuvDeGegDGoH9LF8dE=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-2K4t_HB0NKqa8p0dRG58ow-1; Tue, 08 Jun 2021 15:55:18 -0400
X-MC-Unique: 2K4t_HB0NKqa8p0dRG58ow-1
Received: by mail-oi1-f198.google.com with SMTP id w12-20020aca490c0000b02901f1fdc1435aso6303676oia.14
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=htxg7QFhlugIkUjEBRB6MmryeZkakMXu7uhWLDq62MQ=;
        b=bkhjDOCbuy3o0dwFs/8XOpQd9zVnwboxwjXXU47pYPVUDRObak/WXcchmS/4jgWhWS
         HzKJm0vKPW3U5kWbh/981JR74wQn8r6EbvSUZZLsKFZNDNSzyW3QqZuSfsRjt3cb++wz
         5WLVU8v/E0QGJnwNYb8dxPZRAannDdsrX1ldUUIFm1CB16HJ0IjP+mCdC8cAYxiPT4J+
         CHpoTyEMRNsQPJKjx3vvCQ1sQxPYthmmPewQKVKHNTi/8nMXlU7672rIZmRNq0xqBQ08
         /wM4anh0QStYiY+25yvQKsiJUV9M1qhaJ3z7mmCaHVbRwj+NbVP3xjLjtSiA4ThL52mX
         8qcw==
X-Gm-Message-State: AOAM533kfyq34nZNYIiYyJqkoXd1RCqcYtmV+cQMQxPaR10cSZhR8mMh
        lsQ3HRfFzsSTTCpcLUcE4PO0q3RVRFvAInImzgRi8VoC3lS/aets6D00RYISMsXAdD63o0FrTjd
        sKwRnLijggLlwj2wWOag3uA==
X-Received: by 2002:aca:4703:: with SMTP id u3mr3955503oia.37.1623182117640;
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkQnduqFmHXGXncV3/7jvv7BP7nZordQ4ddUIl4lAERn1K6+6xmEGbcvd4LPsWckV0CQEsPA==
X-Received: by 2002:aca:4703:: with SMTP id u3mr3955495oia.37.1623182117532;
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:17 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 4/7] fpga-mgr: wrap the status() op
Date:   Tue,  8 Jun 2021 12:55:03 -0700
Message-Id: <20210608195506.3022550-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

An FPGA manager is not required to provide a status() op.
Add a wrapper consistent with the other op wrappers.
Move the op check to the wrapper.
Default to 0, no errors to report.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index c484b4309b2f4..cc531f0537acf 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -426,6 +426,14 @@ static ssize_t state_show(struct device *dev,
 	return sprintf(buf, "%s\n", state_str[mgr->state]);
 }
 
+static u64 fpga_mgr_status(struct fpga_manager *mgr)
+{
+	if (mgr->mops && mgr->mops->status)
+		return mgr->mops->status(mgr);
+
+	return 0;
+}
+
 static ssize_t status_show(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
@@ -433,10 +441,7 @@ static ssize_t status_show(struct device *dev,
 	u64 status;
 	int len = 0;
 
-	if (!mgr->mops->status)
-		return -ENOENT;
-
-	status = mgr->mops->status(mgr);
+	status = fpga_mgr_status(mgr);
 
 	if (status & FPGA_MGR_STATUS_OPERATION_ERR)
 		len += sprintf(buf + len, "reconfig operation error\n");
-- 
2.26.3

