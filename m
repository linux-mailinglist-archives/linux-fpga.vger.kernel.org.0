Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B5238F189
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 18:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhEXQ34 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 12:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233873AbhEXQ34 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 12:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=bdNMm5kW2ZvdHUaSawyZ1i2uQbWVxnJCf9si7jFRNcJWD9bLvZ+H8m2d8j6AgjTXEH5oq5
        JOu4xfm67p+i0jh+77CMnid29+wPDOb9v30mH3k+V+gj6HFiUoOjHdbnCU5TaTWi43vTPc
        tyVSi68bdgZWXoap00VmO3neU8DWXhw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-IH8E2o76PCm7ff1EJjKZmQ-1; Mon, 24 May 2021 12:28:26 -0400
X-MC-Unique: IH8E2o76PCm7ff1EJjKZmQ-1
Received: by mail-ot1-f70.google.com with SMTP id r22-20020a0568301216b029031135dd0858so19826618otp.22
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 09:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WMVLkroGznixoNyjbJwPulQLiUxwQzLRzXIYgKX9DDk=;
        b=MR4mGSiifNOjIzvs+j8MfBjjhYGM6a9xLfhVvOPuy4OcMdC+YJHep7/0bfwVvBjPHT
         B6ZSRrin3nzuqo8MBtF1IQ95rGesDTk1Jh26W9EOgvhcHa1JDDMGlET8BBRgpx0YAKjJ
         MZeGkLBIoqSbdiBC8u7f5cQeJsc8BNxtNevp7yG/FuDtyCfmBrZ1DS77iF4eh6s7XOST
         9BfkwCR11Ki3kbZbK/sr6NrpUwTnysmLS2+pUo86dAdCRnrKox+ZjatFpGLOlyYqzir5
         zHCiOUu34XylRFYK7yoWcGKCibltyPcBkITNIIIvaJLNFc1U2H4YWsW5YxXA1Lm+Fvot
         RVaA==
X-Gm-Message-State: AOAM532ChLrnVKKuEDPDV4PaAcCv6rdg6C84T35k/F+n0RB7kcidwSxB
        TydjkXEr0hcWMskTqgXin+OGLigwRFJPbs+woRasXwFvOrFQSUQNsuJoMSh9kTTImfqrVZ/LGIj
        t65gHzgfNV0H4TqD33Wd/Sw==
X-Received: by 2002:aca:3e57:: with SMTP id l84mr5497082oia.146.1621873705669;
        Mon, 24 May 2021 09:28:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwklRD51VQJ2boXV9RmzIVTiIT/5yzbDq5MtMCaKY1kh4wUL3gIuAn+Hw2CK1YyK+AnVw2cKA==
X-Received: by 2002:aca:3e57:: with SMTP id l84mr5497073oia.146.1621873705547;
        Mon, 24 May 2021 09:28:25 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w13sm2691232otp.10.2021.05.24.09.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:24 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 4/6] fpga: defer checking for update ops until they are used
Date:   Mon, 24 May 2021 09:28:20 -0700
Message-Id: <20210524162820.2221474-1-trix@redhat.com>
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

