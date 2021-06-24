Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD3E3B3877
	for <lists+linux-fpga@lfdr.de>; Thu, 24 Jun 2021 23:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhFXVUW (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 24 Jun 2021 17:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbhFXVUU (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 24 Jun 2021 17:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624569480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mFedRc0xrO8oseMlvLubEPJS4VuKtnhUf95dNVhDdKc=;
        b=RCb9gVyh1IFz5l+P9UsIv88Jbt+0dSBZV9nUMxObyupZ2CKWYCdGv6sgOcZtHt1lW3vTMV
        R1RhrHBFxB5FAN/F9Z+v6+ykfY6PkYu76XcYHSEfSTe5jojwk7NeSO1GLvHkwSDk+DjmrH
        zzY/+XK2QBlJFz3crujbXWFc0QAk11o=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-292cKPmQOquz-YKJIl7qAw-1; Thu, 24 Jun 2021 17:17:58 -0400
X-MC-Unique: 292cKPmQOquz-YKJIl7qAw-1
Received: by mail-ot1-f69.google.com with SMTP id y21-20020a0568301d95b029044f7b7f3047so4281391oti.5
        for <linux-fpga@vger.kernel.org>; Thu, 24 Jun 2021 14:17:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFedRc0xrO8oseMlvLubEPJS4VuKtnhUf95dNVhDdKc=;
        b=psmu6gfhVZdOv2KqBCexa93H9f2i4ixSxMdLc6JbcYQZl0pV164IJSmIDrNbVQvQDs
         2dSMm1Gi9LHnXXDCNapISzS9+CwJxu/mJiZ5LeC4qgfsoE7MDHxNgj1Deg3A1T01W1TM
         63FML4YlJg8mFMOMtPbL5dmeE17gPKRtos+tErZxWXhhSQByho7vGQhxtYDkcljGeX6H
         skEADeWd4dKqdOvwiEGxVDziNsY4kvJnbniob8Pa92MnG2w+z8HPygN/ewBBgCVwz3va
         +Emfr8ohpdHNWH8G1JVwBMIxSMS4EkYJnHflEOm+WZv3Ume8eMBOZkY99S1NVFEB9Bqm
         m8Ig==
X-Gm-Message-State: AOAM532FOd+HDkHVzoQATOa0gdgq6P+pSgOlXn0qTwxk9G0NNunMEekI
        yht77IkOtjxzgjK39pTUg5qMZe3/olox0VZdOXp2ltXEGsIfWOAju8gbwxR93bNxpvLRkiOPB5a
        Mun+ErTGrSlvRExSzRu3z8A==
X-Received: by 2002:a05:6830:1ac4:: with SMTP id r4mr6259372otc.36.1624569478212;
        Thu, 24 Jun 2021 14:17:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymkYtjbDACtIBCrlWJa04+yJJF5DcY75EP2JsqstF7I/shhvTHBjE5r+wDrfOsOzapIRL9Aw==
X-Received: by 2002:a05:6830:1ac4:: with SMTP id r4mr6259359otc.36.1624569478058;
        Thu, 24 Jun 2021 14:17:58 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 94sm915513otj.33.2021.06.24.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:17:57 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org, hao.wu@intel.com, michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4 4/5] fpga: use reimage ops in fpga_mgr_load()
Date:   Thu, 24 Jun 2021 14:17:26 -0700
Message-Id: <20210624211727.501019-6-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210624211727.501019-1-trix@redhat.com>
References: <20210624211727.501019-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

If the fpga_image_info flags FPGA_MGR_REIMAGE bit is set
swap out the reconfig ops for the reimage ops and do
the load.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index a785b7dc5dba0..2abb7043858dc 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -420,6 +420,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, info->sgt, uops);
 	if (info->buf && info->count)
-- 
2.26.3

