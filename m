Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0DC39E54B
	for <lists+linux-fpga@lfdr.de>; Mon,  7 Jun 2021 19:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhFGR0c (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 7 Jun 2021 13:26:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231480AbhFGR03 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 7 Jun 2021 13:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623086677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=laSi6Idv6MJlRydvvlMqTdjYXdoIYW3EUNa0fNYB5JY=;
        b=OveqWjvpBEAseSyH2/RrB/h/706n0cfVit98UBk6v0xA3U+Zx5slvH3g2xk8h8jiXmW3Pr
        NLGA7dSDSgba4zlVVFfxzIPE+D7ZOXeYVK2chXZ3fEki+O9E3wKlXwhrc2h2uHQvGIb+NM
        qkvC+uxg2EEOvcrl5xPtI9iqprDkNoY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-92HK_s9SN_qj6XXYXDCWIQ-1; Mon, 07 Jun 2021 13:24:36 -0400
X-MC-Unique: 92HK_s9SN_qj6XXYXDCWIQ-1
Received: by mail-oo1-f72.google.com with SMTP id 3-20020a4a03030000b029024950bdb69dso6435214ooi.3
        for <linux-fpga@vger.kernel.org>; Mon, 07 Jun 2021 10:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=laSi6Idv6MJlRydvvlMqTdjYXdoIYW3EUNa0fNYB5JY=;
        b=Tl+AJiKqJRNwTZla5Yk9qzEcsLOY6QKaYZwTivIzV7YSlvg4RYAPgtDQtqgPLBT43e
         VXgsnXgQdwK8ujQQarzCij9dal5ypBIiR2YzavtsYLp5Dvowbc/CbxDaZ/BSwYRk8PXJ
         icerZUU5E+gmUntEHB37AV5Hs9ck07HawwWtRvyaMwXvOokpem7oIiGSfatyAzN7OEhk
         0W1cGZGUc4VgOJNQ7GcsEqwHt+JV4qNstW21TGPgkoOMQ8YSozvJNIbM8u/r/xQ3vFlO
         VZ8VbDjRKz0qPHyHawdy1a59cHvS0xgSZLCt+Gsgq+A2htb7pZviUzmhFZZA9ch9Jaim
         zy1g==
X-Gm-Message-State: AOAM531F/pBApHGV5jT/TKVoADv0PIji4F5tsmnyj2aRR7ZxzIgNgp/z
        8pnLSZpT2hjMwZWEqV45I/fuh1IArClawUgxskiRmToCBPpkPIUroC4eouSbRqAHnox6wkDvhVM
        M8Q63sa3hBhKVeXnFtXoWiw==
X-Received: by 2002:a9d:289:: with SMTP id 9mr14127917otl.10.1623086675885;
        Mon, 07 Jun 2021 10:24:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0Mxu9OWeXq29nlPkEMpqQQx4J506+qxFfVHTsHRyJukzcKWG9aLTPxri3PNB8lw79Q0A/dw==
X-Received: by 2002:a9d:289:: with SMTP id 9mr14127899otl.10.1623086675698;
        Mon, 07 Jun 2021 10:24:35 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 15sm2409859oij.26.2021.06.07.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 10:24:35 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH 6/7] fpga: wrap the fpga_remove() op
Date:   Mon,  7 Jun 2021 10:24:01 -0700
Message-Id: <20210607172402.2938697-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210607172402.2938697-1-trix@redhat.com>
References: <20210607172402.2938697-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The board is not required to provide a fpga_remove() op.
Add a wrapper consistent with the other op wrappers.
Move op check to wrapper.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index d06752be9c6e..84808c7ca440 100644
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

