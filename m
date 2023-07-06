Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40467749EFC
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Jul 2023 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjGFO3C (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jul 2023 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjGFO3B (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jul 2023 10:29:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD231732
        for <linux-fpga@vger.kernel.org>; Thu,  6 Jul 2023 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688653696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOMqxFOjwhp1sr/qCndFS1unAUJRkXxGEaTi00qWpSg=;
        b=GFRf2dq5sX8IZchEBfd6oVYj4Cl0BCpEmCRnUjTctZJCuvZ05nSGrRAZotvPWuP1cdRLvt
        IqMXsk+TTXjonUPNXgqf6Uil9LukxY6RQozJ29K4JzRCO8KDDjMNryNRRvcbpuJJTeohFy
        11nhZ1UlChaXtPxMsZiTPGzxgkrOZBs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-2YJki0tZMGGhXI5SmsXrVQ-1; Thu, 06 Jul 2023 10:28:15 -0400
X-MC-Unique: 2YJki0tZMGGhXI5SmsXrVQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635325b87c9so9499116d6.1
        for <linux-fpga@vger.kernel.org>; Thu, 06 Jul 2023 07:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653694; x=1691245694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOMqxFOjwhp1sr/qCndFS1unAUJRkXxGEaTi00qWpSg=;
        b=HD7/it/fGCde7/UFnymAo7g4vS5lsxNS9wVvV9Q4B36ihEoiK5NIffNcqd8Ch5VHru
         azEbg4jlPpoL3AEBymIPs3XHSdvm9wJ6ASJv83iPQPXzS1sqXrW6h3QmqKkGp/Madmqo
         AyVq9p5yQZTWWyh2ZGPLGrsaUSwshhjG1TaoWco0aInDVH4kiUjo9qTIz7axMkAy8ghv
         AVc3aBTq92egFh3nMR0ud4twU0GpK/FFaYY3tXqiUUAvePgnICdNQt9JN6Q24BahJt+r
         SgGBBHMNEpTeGUwlhq+J2ryPe2Uk0K7v00iyN6JIbm1xNS+Ts3Omdp6zBmnGZyjHOJ9Y
         XtrQ==
X-Gm-Message-State: ABy/qLalWech/lb0kW8d6F1Vw640/9js8wl+W8tX8N4IBQTgcnUqeZnM
        /hrTMRH8WvkmbRQPlnmmX8+OC5bUhtvBHeAVuCXhqZ8GyMjkrICDyXpKNuaTPVeEd4ggnB9vODm
        qBm9DgVqI9+xfTQrq+Wv8JpgN0W6X
X-Received: by 2002:a0c:cd09:0:b0:62d:fddb:1856 with SMTP id b9-20020a0ccd09000000b0062dfddb1856mr1632418qvm.43.1688653693404;
        Thu, 06 Jul 2023 07:28:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0y438reE5zjXcfDA7xUYnNrfLuDVwrxlHfu4NCHzXOuaLWtwVFf9gTuweECoZsXnlFMPAQg==
X-Received: by 2002:a0c:cd09:0:b0:62d:fddb:1856 with SMTP id b9-20020a0ccd09000000b0062dfddb1856mr1632397qvm.43.1688653693121;
        Thu, 06 Jul 2023 07:28:13 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id r21-20020a0cb295000000b0063631be090csm923526qve.125.2023.07.06.07.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:28:12 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 1/2] fpga: region: fix kernel-doc
Date:   Thu,  6 Jul 2023 16:27:54 +0200
Message-ID: <20230706142755.124879-2-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230706142755.124879-1-marpagan@redhat.com>
References: <20230706142755.124879-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

- Fix the following warnings issued by the kernel-doc script:

drivers/fpga/fpga-region.c:46: warning: No description found for return value of 'fpga_region_get'
drivers/fpga/fpga-region.c:97: warning: No description found for return value of 'fpga_region_program_fpga'
drivers/fpga/fpga-region.c:295: warning: No description found for return value of 'fpga_region_init'

- Remove the "and registers a reconfig notifier" part from the description
  of fpga_region_init() since it does not register an of_overlay notifier
  anymore.

- Remove the outdated "if @np is not an FPGA Region" case from the return
  description of fpga_region_get() and replace it with the case when
  try_module_get() fails.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/fpga-region.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index ccf6fdab1360..c9d065a6961b 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -38,9 +38,10 @@ EXPORT_SYMBOL_GPL(fpga_region_class_find);
  *
  * Caller should call fpga_region_put() when done with region.
  *
- * Return fpga_region struct if successful.
- * Return -EBUSY if someone already has a reference to the region.
- * Return -ENODEV if @np is not an FPGA Region.
+ * Return:
+ * * fpga_region struct if successful.
+ * * -EBUSY if someone already has a reference to the region.
+ * * -ENODEV if can't take parent driver module refcount.
  */
 static struct fpga_region *fpga_region_get(struct fpga_region *region)
 {
@@ -91,7 +92,7 @@ static void fpga_region_put(struct fpga_region *region)
  * The caller will need to call fpga_bridges_put() before attempting to
  * reprogram the region.
  *
- * Return 0 for success or negative error code.
+ * Return: 0 for success or negative error code.
  */
 int fpga_region_program_fpga(struct fpga_region *region)
 {
@@ -288,8 +289,9 @@ static void fpga_region_dev_release(struct device *dev)
 }
 
 /**
- * fpga_region_init - init function for fpga_region class
- * Creates the fpga_region class and registers a reconfig notifier.
+ * fpga_region_init - creates the fpga_region class.
+ *
+ * Return: 0 on success or ERR_PTR() on error.
  */
 static int __init fpga_region_init(void)
 {
-- 
2.41.0

