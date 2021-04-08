Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B59743579DF
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 03:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhDHBsS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 7 Apr 2021 21:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbhDHBsR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 7 Apr 2021 21:48:17 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9B7C061760
        for <linux-fpga@vger.kernel.org>; Wed,  7 Apr 2021 18:48:07 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id p10so223793pld.0
        for <linux-fpga@vger.kernel.org>; Wed, 07 Apr 2021 18:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SEMD+jWIhf3/qwyBM/4WAt/D/SNE57qBGn/qHwetRTw=;
        b=vL5t64+eERfAPpLQH6OC5TqbZxpz9lfwehOC0shRNB1MgJjQl1bpKL1igPlWRYVF/Y
         r/nbkpMM0vywaetcIaiwlyK/2dCLVsQl/izgl0Nn5O35NZBPMFOPtD7WjIQOW4GiOe3W
         P2YVmNNLWrEH8thwfcqVtR69n03uBCbVswleF5EDR3wFOKDOK/6c5gwVxXNlSjhZcx3z
         nZGprv/JVikLhtOQVXqGFPq9upU/pmS8scZZcYA6Mor+gd8+hmnZwakIWfCaZQ+ZkwYF
         u3b2tVzbDtQw6XSmssNUg/D51+ZF+f9vRvYb2Cwbx/fzZK9Z+BJwQBxMaHSrLMPCq6Ih
         uxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SEMD+jWIhf3/qwyBM/4WAt/D/SNE57qBGn/qHwetRTw=;
        b=YfFgwZ21UfEUipvk5ijupWyTmaf94qFmEI/XMnaKyY9PyqgkJv7uRvUotIGxCYZ9Lv
         mhLEoYQEn8mS6KvGWi9/W3CNKmKhpw5PXXSAFbFE0th6ij94jIoMJI3qH2Rk04uNGmV9
         G1KkHMIKRbhCrGCaVEzrFrcdSDEZAa/ukjvtrhwF3j8SgEEb0YzXfSq3o2CElDYfh4NE
         SKBlYR2s1hzTozOJLLv07nDLyJii5I0gsO94yQNV2F5CuvVfrzG+zRCTrgD/TGqq0709
         WrvpxtxjxjMFXss2P97N/8WTi62S8mARlJ3cpykiPeLEWXLhUGlTk+A75hIuBC8/6zM3
         JzpA==
X-Gm-Message-State: AOAM531KpVcsfprowWWcr2G3yucZfsFl8AiNBhMZXv2oyxhifHIWYY7f
        Ahz9gAowqAMRw6U+j612MfE=
X-Google-Smtp-Source: ABdhPJzcZV2p9RVd1XjDb73Q/EqMyboT+IeBCZlXEwVaKe8+vZfYoML+5+/biNvunE5Cd8ss4eYazA==
X-Received: by 2002:a17:902:bf07:b029:e7:137c:2e25 with SMTP id bi7-20020a170902bf07b02900e7137c2e25mr5420192plb.67.1617846486745;
        Wed, 07 Apr 2021 18:48:06 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id b7sm9347740pgs.62.2021.04.07.18.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 18:48:06 -0700 (PDT)
From:   Moritz Fischer <moritz.fischer.private@gmail.com>
X-Google-Original-From: Moritz Fischer <mfischer@archbook>
Date:   Wed, 7 Apr 2021 18:48:08 -0700
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager addtional 5.13 changes
Message-ID: <YG5g2KNJiDU37E8+@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6f1e376cfc6864a2f46538db909bbd5253c3c146:

  fpga: Add support for Xilinx DFX AXI Shutdown manager (2021-03-06 07:54:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-late-for-5.13

for you to fetch changes up to a78a51a851ed3edc83264a67e2ba77a34f27965f:

  fpga: dfl: pci: add DID for D5005 PAC cards (2021-04-05 17:46:56 -0700)

----------------------------------------------------------------
Second set of FPGA Manager changes for 5.13-rc1

FPGA Manager:
- Russ' first change improves port_enable reliability
- Russ' second change adds a new device ID for a DFL device
- Geert's change updates the examples in binding with dt overlay sugar
  syntax

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      dt-bindings: fpga: fpga-region: Convert to sugar syntax

Russ Weight (2):
      fpga: dfl: afu: harden port enable logic
      fpga: dfl: pci: add DID for D5005 PAC cards

 .../devicetree/bindings/fpga/fpga-region.txt       | 187 ++++++++++-----------
 drivers/fpga/dfl-afu-error.c                       |  10 +-
 drivers/fpga/dfl-afu-main.c                        |  35 ++--
 drivers/fpga/dfl-afu.h                             |   2 +-
 drivers/fpga/dfl-pci.c                             |  18 +-
 5 files changed, 127 insertions(+), 125 deletions(-)
