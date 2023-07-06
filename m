Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B53749EFB
	for <lists+linux-fpga@lfdr.de>; Thu,  6 Jul 2023 16:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjGFO2z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 6 Jul 2023 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGFO2y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 6 Jul 2023 10:28:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F991737
        for <linux-fpga@vger.kernel.org>; Thu,  6 Jul 2023 07:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688653687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MDsrBevz7syP5s6zTN3OcMgPS6Mla1kJtKeysSHnSkw=;
        b=bWxbvEN0KqkewYdcf+14uCXIICi7iZ3QnJ8Yjie6oZuDWVAbUBUrasTgwivRgoPqntGgY6
        Lj/XKqDaE2/ivsC76mOsT2Sp1ik6sNWI9Giu94IEpbl/ex04rKfzHNEd7mDVK33arUqMf5
        fWIWqo9EkdGA1TjfTHbhKtpCHWD/2+4=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-CfKXCmHsPe-Xk9WyM_uGEw-1; Thu, 06 Jul 2023 10:28:06 -0400
X-MC-Unique: CfKXCmHsPe-Xk9WyM_uGEw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-39cb2a0b57aso767212b6e.1
        for <linux-fpga@vger.kernel.org>; Thu, 06 Jul 2023 07:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688653685; x=1691245685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDsrBevz7syP5s6zTN3OcMgPS6Mla1kJtKeysSHnSkw=;
        b=aJ5LVhOl8ooGdL7a2kC5Ga13g25DJbU9mdteXxzhCO9x7DVCC7lbJcQxUswwt6z0H0
         2WXGAa5sg0lhRYdm9emuj2hWE1XcWgkzN7BVbDg0Ar6s4ffHZRW5WOaPSJos/HuV5MgY
         mCqP5mVFFG/iQlH61aetzhh5ivmol+SCX2CBclf16vI6/OHdDF6LFEN0PHQLfTAU5gHo
         Ux8G2NWgfstRJObZCGtDMGeaQKS1PGqOP19QKyRWYbUY1OyENlK47Vqusv0Uioi2nbxX
         ujVz147fGw90J86LzjATi+kZ4gV8N77UvXQe2KYMEUsvAbzx8B+P4khqHXWuOXJfD9VJ
         gDCg==
X-Gm-Message-State: ABy/qLYSK19LVBO0c2xRkS7nIys+8vmUDWaH4JdxW80WEebMrDF8IaQI
        nk/3S0D+RHctHFb3Eftp24RmsnaVrgKIZ+UzRBOozGKBo4mblXk4V8OKZSxHXPBfb88dpcfim7W
        ChoaURUkvKiqX8K4WUvJl
X-Received: by 2002:aca:190c:0:b0:3a3:9c50:8fe2 with SMTP id l12-20020aca190c000000b003a39c508fe2mr1813669oii.31.1688653685389;
        Thu, 06 Jul 2023 07:28:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0dKP8CI+A4rkmpg1pA9vYJSHY2VXmoDqgrofAlyIMvkdC7zS3UoECI7jB/w/GZuO0Ubk3dQ==
X-Received: by 2002:aca:190c:0:b0:3a3:9c50:8fe2 with SMTP id l12-20020aca190c000000b003a39c508fe2mr1813660oii.31.1688653685178;
        Thu, 06 Jul 2023 07:28:05 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id r21-20020a0cb295000000b0063631be090csm923526qve.125.2023.07.06.07.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 07:28:04 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [RFC PATCH 0/2] fpga: fix kernel-doc warnings and align descriptions for the core components
Date:   Thu,  6 Jul 2023 16:27:53 +0200
Message-ID: <20230706142755.124879-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch set fixes all kernel-doc warnings reported by the kernel-doc
script for the core components of the subsystem and aligns descriptions
with current implementations

Marco Pagani (2):
  fpga: region: fix kernel-doc
  fpga: bridge: fix kernel-doc

 drivers/fpga/fpga-bridge.c | 23 ++++++++++++-----------
 drivers/fpga/fpga-region.c | 14 ++++++++------
 2 files changed, 20 insertions(+), 17 deletions(-)


base-commit: 45a3e24f65e90a047bef86f927ebdc4c710edaa1
-- 
2.41.0

