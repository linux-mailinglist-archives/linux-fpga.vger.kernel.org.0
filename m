Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06723A04BD
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 21:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhFHT5d (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 15:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28887 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234719AbhFHT5S (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 15:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623182124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ub84QQXk/80gOx9jVYvQgeu9ZbjU0KtFBnV/GBkRc70=;
        b=V3ThtLMcL6fuXSRwKkZ56m/m60A9yhH+fPvD6I51FZY1Iq9YzlxCPySnskiUDyNDBPD1Rs
        d5EUKR+WpFgM4QeK0XlTyNeCd+gKjR9CEUv4fGHICBocI8DS6FRKVKVaE0HO4yPqezgUZI
        xK0eypU2jIXjRGaxtKJ9U/EG9qwLF/Y=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-nleR9qMRPB6Iehy7fu7wBg-1; Tue, 08 Jun 2021 15:55:21 -0400
X-MC-Unique: nleR9qMRPB6Iehy7fu7wBg-1
Received: by mail-oi1-f200.google.com with SMTP id p5-20020acabf050000b02901eed1481b82so8830730oif.20
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ub84QQXk/80gOx9jVYvQgeu9ZbjU0KtFBnV/GBkRc70=;
        b=LHgh/FPH0hdmKMcv9dmRUXk2P+M22xlS9oKB9XCVMo9OE1/uFrGJB42AEpdvAQ7N8d
         Awm6qn4zyGOFBSr1cSqWPkjKC47LxD9FoLk1alUV4npCNSYE3JNDKrn6qBNffF+akEsp
         0k+k4+Sd/Ul9rdn9IQBtIGlu14G/XaMT0ViJ9lp9Iu4dO2J4hIETT3jiMsFnH8Ts4UDa
         x1G38vSRY/ckyJ1kIoDKjPp+FLwaL6zqoCzQ0P48ZhLiFphnHLd7JalLf1ftsU52R9l/
         8fKnLfRKnEw7sCawmANwoXPtVN6hyOTyVZE4UlBEErml+zXza04f7mF3KWo436E1fqo6
         6Aqg==
X-Gm-Message-State: AOAM530sa0x6M9gAAJK0AJzOx6ePvcNI+nSDa5LTB8K/bowaqgYyufop
        CfLctfPcowhL8j8hr35YARuQAzunl/2gHz2fcroG+61LoV03ErNr44PYPG8klNZDJVO/B7OTaLj
        eyhTLWHVd4YWmI0j2H4aONg==
X-Received: by 2002:a9d:2904:: with SMTP id d4mr19095276otb.238.1623182120325;
        Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmGhb5zky/LBefjfpgPpDFor2hP6i0wi5WpKPdZompoRWYG/9Z6TmmFlW3LXeN5nlet8+wrw==
X-Received: by 2002:a9d:2904:: with SMTP id d4mr19095265otb.238.1623182120144;
        Tue, 08 Jun 2021 12:55:20 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm3024046oog.31.2021.06.08.12.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 12:55:19 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 6/7] fpga-mgr: wrap the fpga_remove() op
Date:   Tue,  8 Jun 2021 12:55:05 -0700
Message-Id: <20210608195506.3022550-8-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608195506.3022550-1-trix@redhat.com>
References: <20210608195506.3022550-1-trix@redhat.com>
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
index d06752be9c6ef..84808c7ca4406 100644
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
  * fpga_mgr_unregister - unregister a FPGA manager
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

