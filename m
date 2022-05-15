Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3758A527A77
	for <lists+linux-fpga@lfdr.de>; Sun, 15 May 2022 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiEOVsl (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 15 May 2022 17:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiEOVsl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 15 May 2022 17:48:41 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB2EEE09
        for <linux-fpga@vger.kernel.org>; Sun, 15 May 2022 14:48:37 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id j6so12388928pfe.13
        for <linux-fpga@vger.kernel.org>; Sun, 15 May 2022 14:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+DZmOdrBjecVLFvcLSDnIUU5cvv4JPHwOh5/ASxX8z0=;
        b=rMaP6Eubhca1wiU5e37KIzoUWs3Xp0k/5aZY7b3IHLA2I9uei3EYnQ1qNrxXXxyyWA
         HmWAQSMJNoXG9k2ZOYrlOstxRmlqVRZeoLrsPxGLcNyGIYXmwe3iPqG7nB3ODJLTxaTt
         79zxZmH/yhHfVVxlpjPiOCi7cxch8Y7CpiLkhj4woniS8lfrDXiB06JVGR635tghAknV
         Ivz9TID+anMVzn1CnRc/Q5TVcNL/SF2b9+K3UbbbOBb4QqXhqUZCs7TGH0n+f6fi5Czd
         Q6f/lOH7F83QwMVjXi8WmXlGbfM40b2A066aQBDlkfcW7Oz+bZb+ueN2KQWgSvI1emBh
         toUg==
X-Gm-Message-State: AOAM5321oO2Bb0MlahtNUhP7nqi7/Ow3dbUHrRbrxElyKmf2P/yU6Ch6
        l62qZL5zPJUzGy0PPzfDwoA=
X-Google-Smtp-Source: ABdhPJxmNbAA9ZIBr6bNXT5UHbfHwPn4lxuZBKFaJTUsQxhiik+qYs/koj7BYWjxNcoPCEsW82YY0Q==
X-Received: by 2002:a63:81c3:0:b0:3da:fbf1:16ce with SMTP id t186-20020a6381c3000000b003dafbf116cemr13364131pgd.62.1652651316415;
        Sun, 15 May 2022 14:48:36 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090ad51800b001dc1e6db7c2sm6992570pju.57.2022.05.15.14.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:48:35 -0700 (PDT)
Date:   Sun, 15 May 2022 14:48:34 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, yilun.xu@intel.com, hao.wu@intel.com,
        moritzf@google.com
Subject: [GIT PULL] FPGA Manager changes for 5.19-rc1
Message-ID: <YoF1Mo1ZK69orQ0I@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga tags/fpga-for-5.19-rc1

for you to fetch changes up to ae23f746d7442909a19bd43397b567145d6e5db3:

  fpga: dfl: Allow Port to be linked to FME's DFL (2022-05-10 16:05:38 +0800)

----------------------------------------------------------------
FPGA Manager changes for 5.19-rc1

FPGA Manager

- My change moves the linux-fpga repository to a shared
  location w/ shared responsibilities between maintainers
- Nava's changes fix coding style and kernel-docs

DFL

- Matthew's change allows ports to be linked to FMEs.
- Tianfei's changes clean up some documentation and
  ensure the feature type is checked before parsing IRQs

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of our for-next branch).

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Matthew Gerlach (1):
      fpga: dfl: Allow Port to be linked to FME's DFL

Moritz Fischer (1):
      MAINTAINERS: Update linux-fpga repository location

Nava kishore Manne (4):
      fpga: fix for coding style issues
      fpga: fpga-mgr: fix kernel-doc warnings
      fpga: Use tab instead of space indentation
      fpga: fpga-region: fix kernel-doc formatting issues

Tianfei zhang (2):
      fpga: dfl: check feature type before parse irq info
      Documentation: fpga: dfl: add link address of feature id table

 Documentation/fpga/dfl.rst       |  5 +++++
 MAINTAINERS                      |  2 +-
 drivers/fpga/Makefile            |  6 +++---
 drivers/fpga/dfl-pci.c           |  9 +++++++++
 drivers/fpga/dfl.c               | 38 ++++++++++++++++++++++----------------
 drivers/fpga/dfl.h               |  1 +
 drivers/fpga/fpga-mgr.c          | 13 +++++++++----
 drivers/fpga/fpga-region.c       |  6 +++---
 drivers/fpga/of-fpga-region.c    | 22 ++++++++++++----------
 include/linux/fpga/fpga-region.h |  6 +++---
 10 files changed, 68 insertions(+), 40 deletions(-)
