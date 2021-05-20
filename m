Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD438B5F9
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 20:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbhETSak (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 14:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31047 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231634AbhETSak (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 14:30:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621535358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KuRG9vWY0jfUiOP1f57t7lLfBEAT6/lfYeU935poEww=;
        b=agLdnSyrVT7KZMnsFrFBwtkw+hFDN+/YPjIKP5h8evDlmsQ/dhUSXGMPzGDHO8YeO/0goO
        aAFu83ZpvcWxSMAE2jw+AfjqIHTtSOBTLaA/ZRIeqidkz5QKJgi7v5fkfGE5ZvjZCGmoLS
        XtuVIVfNkXxy7VImbCgTY+RyNuYigF4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506--YqaseA-PRO93N1du4HZNw-1; Thu, 20 May 2021 14:29:16 -0400
X-MC-Unique: -YqaseA-PRO93N1du4HZNw-1
Received: by mail-qv1-f72.google.com with SMTP id bc3-20020ad456830000b02901f47dbd7ef6so4024660qvb.6
        for <linux-fpga@vger.kernel.org>; Thu, 20 May 2021 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KuRG9vWY0jfUiOP1f57t7lLfBEAT6/lfYeU935poEww=;
        b=RktaZg2qBBbe7kkibRTlncpyh8EWA1ki5V1rb8f4AQaB6ju2OmE7y4TkcHnhLE3H5B
         xrrBfWErVSI+Kp/8NYh1ykitUgMyoLWguIxh//NTI5JnaaJPa/Ivx8fkbO2jaBZmoLlf
         jh/xPAjsKToJFXKgpwHnUr789Tqb6ybRimR6mMmwjGoqxjvG7oSH/HTm0CyxMCjewt2x
         Rsy+6x+2mZVuxmzPd0DXm2mNylIDywj8sb+0BwGw/LgMZ+y0MRrUTl5luQFhBo7Rn3g0
         eGdMxGjRVNrVDYl1U1xvJSuzMizgWIVV4jP9l4Vlvlx/tOrNpdWIz0SYQVK0mjxRkxfJ
         /yAg==
X-Gm-Message-State: AOAM532vLogyzJ7mR+4ag6VDR4eXKRDV0nVEXBbWUw5IJNcS40V1ADgB
        U7F4Ooy5Oc4ltK1Iu1g5F970iO5HG125MucW6/ktuB90tUdY+H1eBS4kB93zJGij2yLFF4/oyeA
        TQh7NTlz4yT3ctaoqxlGsbA==
X-Received: by 2002:a37:a309:: with SMTP id m9mr7206202qke.126.1621535355837;
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwldeFbz0RULF07VGqpc5h9My9BH9z98cOaZH/dSszgRT8CgQ/ebLHUQRBrmVYBM65/8fiWkg==
X-Received: by 2002:a37:a309:: with SMTP id m9mr7206181qke.126.1621535355674;
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l10sm2702932qtn.28.2021.05.20.11.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 11:29:15 -0700 (PDT)
From:   trix@redhat.com
To:     russell.h.weight@intel.com, mdf@kernel.org, hao.wu@intel.com,
        michal.simek@xilinx.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2 0/5] generalize fpga_mgr_load
Date:   Thu, 20 May 2021 11:29:06 -0700
Message-Id: <20210520182906.2021594-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A refactor of the fpga-manager to make space for the
functionality of the secure update in this thread.
https://lore.kernel.org/linux-fpga/20210517023200.52707-1-mdf@kernel.org/T/#mf3a1951d429a973c863eee079ed990c55056827c

Splits the reconfig write ops into its own ops structure and
then has an instance for the existing loading (reconfig) and the
secure update (reimage)

fpga_mgr_load uses a new bit, FPGA_MGR_REIMAGE, in fpga_info_info
to use either the reconfig or the reimage ops.

valid write op checking has moved to make the reimage path option.

Since fpga_image_info_alloc zalloc's the fpga_info_struct, the
reimage path will not be taken.

Changes since v1:
- update op names changed from
  partial_update to reconfig
  full_update to reimage
- dropped the cancel() and get_error() ops.
- add FPGA_MGR_REIMAGE bit
- refactor fpga_mgr_load to use either update ops

Tom Rix (5):
  fpga: generalize updating the card
  fpga: add FPGA_MGR_REIMAGE flag
  fpga: pass fpga_manager_update_ops to the fpga_manager_write functions
  fpga: defer checking for update ops until they are used
  fpga: use reimage ops in fpga_mgr_load()

 drivers/fpga/altera-cvp.c        |  8 ++--
 drivers/fpga/altera-pr-ip-core.c |  8 ++--
 drivers/fpga/altera-ps-spi.c     |  8 ++--
 drivers/fpga/dfl-fme-mgr.c       | 10 ++---
 drivers/fpga/fpga-mgr.c          | 72 ++++++++++++++++++++------------
 drivers/fpga/ice40-spi.c         |  8 ++--
 drivers/fpga/machxo2-spi.c       |  8 ++--
 drivers/fpga/socfpga-a10.c       | 10 ++---
 drivers/fpga/socfpga.c           |  8 ++--
 drivers/fpga/stratix10-soc.c     |  8 ++--
 drivers/fpga/ts73xx-fpga.c       |  8 ++--
 drivers/fpga/xilinx-spi.c        |  8 ++--
 drivers/fpga/zynq-fpga.c         | 10 ++---
 drivers/fpga/zynqmp-fpga.c       |  8 ++--
 include/linux/fpga/fpga-mgr.h    | 35 +++++++++++-----
 15 files changed, 125 insertions(+), 92 deletions(-)

--
2.26.3

