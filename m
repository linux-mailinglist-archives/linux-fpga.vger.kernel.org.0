Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0852B38F18D
	for <lists+linux-fpga@lfdr.de>; Mon, 24 May 2021 18:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhEXQaQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 24 May 2021 12:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233026AbhEXQaQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 24 May 2021 12:30:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621873728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=CKiOwBs86tuCfvZ7SLf2moKR38PHq5qGHiZvKIS4I0HbdKErjWSIIDZWzFHOU2MyJisjQ9
        opBa9uLXzW2UQgjil33c67UhdLJ+EPdY0Cit1KdQhvU4fU2MtrYZvXC0MhdjKp4U0EPTU7
        U79H4O4nBi0l3+NXGAdng1oxHu75g3Y=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-H0hom3wrMcyywE93bf6aIw-1; Mon, 24 May 2021 12:28:46 -0400
X-MC-Unique: H0hom3wrMcyywE93bf6aIw-1
Received: by mail-ot1-f72.google.com with SMTP id h8-20020a9d6a480000b02902edb9406104so20104563otn.5
        for <linux-fpga@vger.kernel.org>; Mon, 24 May 2021 09:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rzVWT+hgucJulWTbb27JAU0YdQhBiQeXz3Y6dtzUOvc=;
        b=kP962BbKUHeM8/RHNjnbzRCuGz7L9zDIaNBmgkTnzILRHdtDE1NuxdNOenxUEw2dWd
         aDVr8XYm0SJbk5VJ0bkUVjCbgjTQxhAcYpOPBmck77h5oi2lj9txFvPOAxaNhZN4VzCP
         zzg0HdZ1FkJ8alnMFCkdYo99oUVeXm0TS/0ocSLNk8f5ftRbJ6j6bQv6GhGD+yG64xwb
         VwKEVmifHNDoBAnfRG5bBQuz/N/+blQ9qMLJcYMP2seeR9v+vysIIZSQ9LcHV+1P2pca
         ACwQa/EeC7Qa1iOOs/xY6yhIehNKHvrIM3uxO9imWnKMw6+ZgChgl+KZ0oSsgK2KZCOa
         f7sQ==
X-Gm-Message-State: AOAM532lgJcUjBzwUI6CpJ2A61Ft2EdPOvTccXW3BNmdTL0kMCga52Dx
        b2Dq1jGp0yD7mpcj58WvcXQs7nJnMaskLRb5u8zXLzrJmXpt94INbu9P3T5TiQEUFZv80blvtIt
        0ef62BfDdAOI9bhFpto62hw==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr11039794oif.17.1621873725927;
        Mon, 24 May 2021 09:28:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZCllVamKPDAcqNe9vkFb8F/MCgjRAEAJeL9eXqfRMBxwbIVKkyvMaaHJTDZ2qwSv/+R2VXg==
X-Received: by 2002:aca:b3d5:: with SMTP id c204mr11039784oif.17.1621873725765;
        Mon, 24 May 2021 09:28:45 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q26sm3111066otn.0.2021.05.24.09.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 09:28:44 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v3 5/6] fpga: use reimage ops in fpga_mgr_load()
Date:   Mon, 24 May 2021 09:28:37 -0700
Message-Id: <20210524162837.2221590-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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
index 5247703a3743d..34d251e87ca6c 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -369,6 +369,9 @@ int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info)
 {
 	const struct fpga_manager_update_ops *uops = &mgr->mops->reconfig;
 
+	if (info->flags & FPGA_MGR_REIMAGE)
+		uops = &mgr->mops->reimage;
+
 	if (!uops->write_complete ||
 	    !uops->write_init ||
 	    (!uops->write && !uops->write_sg) ||
-- 
2.26.3

