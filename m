Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F089338B60B
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234895AbhETScS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27869 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233462AbhETScR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:32:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=De8JqYzgcdOqqtwpKgspgmLaQo3MGQdmgepvV8gZ4cyyNmyKidWVe7NjgxrtA6iVTDDgFO
        Lt6c/AJFRJ6kGBpg//w+w2/SZysGUYp18B6Pf3Vz/cO490p2NSZaMKmJWSxth2kS+cOKST
        Pi/Fya7MwgmASEJ/r1LO3vslfMgIl+E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-NeOBcbhJN9mw0VmPiIgYiQ-1; Thu, 20 May 2021 14:30:54 -0400
X-MC-Unique: NeOBcbhJN9mw0VmPiIgYiQ-1
Received: by mail-qt1-f199.google.com with SMTP id i12-20020ac860cc0000b02901cb6d022744so12943282qtm.20
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=RGs31XjHQOfVS1GQ/+FhEFKUzh0/AlBC70Bhy92z9Jy3myiG2BHBMyQnosCFv3CasQ
         ChQL4HJtu9aiI4TPwC9+ZS8OP4QWGTQMiTAhEU4pg9ORDVMTW2bh7EJ/shLe3RJHw6o/
         hgPIOYY8QneCy3os79wTXWS1pIivuWizCYYgKpOlMJsZB0wuX2liVFtMXWiwFWteGWTM
         OG2BjqWV50PBBnB3GbCWNFpEfApTSTxHzhvA/Ni/LOu2FCBJ2bdeUO0RnSiq4B4BbBIT
         sQB3y2xew0L9fIibL4nFni2MKXKrfcnJW8hgYqIMZCgnKBuO918aqzRWdhUK7dz66gkS
         6/nA==
X-Gm-Message-State: AOAM5317NPH8sqZMmiMWL+2Z/e9qwKazy393bhALmTRJ0xoKP9IQS3pk
        PKQf/fm6Lj+PDS+hS88GHuwDAxocWgofJ2ZEmOg4VHgJ2lB1xGjADu/sLH2g/ylA6beO8Z55GZ3
        plcy/4x6HdvJiLSGJ8IZ1wg==
X-Received: by 2002:ac8:7ef2:: with SMTP id r18mr6698647qtc.333.1621535453806;
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypqNQnjLGYPT9cwZhXzhzvHWqROXjiEksYjG//nhkya+T2M49M4zItRGoqs+JifXjOAf4e0g==
X-Received: by 2002:ac8:7ef2:: with SMTP id r18mr6698627qtc.333.1621535453658;
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t17sm2377264qto.92.2021.05.20.11.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:30:53 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 4/5] fpga: defer checking for update ops until they are used
Date:   Thu, 20 May 2021 11:30:48 -0700
Message-Id: <20210520183048.2022642-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Which update ops need to be used will depend on the
FPGA_MGR_REIMAGE bit in the fpga_image_info flags.
reimaging is optional, no drv that does not need
to remimage should be forced to provide stub functions.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index 4263c9e94949d..5247703a3743d 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,14 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (!uops->write_complete ||
+	    !uops->write_init ||
+	    (!uops->write && !uops->write_sg) ||
+	    (uops->write && uops->write_sg)) {
+		dev_err(&mgr->dev, "Attempt to load an image without fpga_manager_update_ops\n");
+		return -EOPNOTSUPP;
+	}
+
 	if (info->sgt)
 		return fpga_mgr_buf_load_sg(mgr, info, uops, info->sgt);
 	if (info->buf && info->count)
@@ -579,10 +587,7 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 	struct fpga_manager *mgr;
 	int id, ret;
 
-	if (!mops || !mops->reconfig.write_complete || !mops->state ||
-	    !mops->reconfig.write_init || (!mops->reconfig.write &&
-						 !mops->reconfig.write_sg) ||
-	    (mops->reconfig.write && mops->reconfig.write_sg)) {
+	if (!mops || !mops->state) {
 		dev_err(dev, "Attempt to register without fpga_manager_ops\n");
 		return NULL;
 	}
-- 
2.26.3

