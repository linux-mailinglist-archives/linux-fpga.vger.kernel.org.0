Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A67A3B4A18
	for <lists+linux-fpga@lfdr.de>; Fri, 25 Jun 2021 23:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFYVW3 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 25 Jun 2021 17:22:29 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:35377 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFYVW2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 25 Jun 2021 17:22:28 -0400
Received: by mail-pf1-f170.google.com with SMTP id d12so746894pfj.2
        for <linux-fpga@vger.kernel.org>; Fri, 25 Jun 2021 14:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=vvrTNhT0oiMwfxNvT3bQYTLVmBOpC/RZb1+ZYSJ25G0=;
        b=UlRvkSHdeX5jzeh3+rfXNN1Dv+Cokq6IOHNQWRrAA8zoIA4Smz97sab+Y/SArMyn1I
         EGpSQ2ghpwDm3LAuD2ZK/UOlEzAz7qxMBoPHA82iA3CP6KpNnRZZg2JXdEV1T2lzLMRU
         fygyQ6ILO73GXLsfoOx7ZFA0RuypwgUhbh2j3e7uGxwYRTJFS03pKQ/Xyo/1aDrXKgMM
         rk7wqWgKEX16p5svb+dCrvScr9iS3otNRrEnGeWFGTrJ6LpWSaeW+Q4S6+liWamSGfeO
         Z/imhR6TmwwzVRUOG3QN60Me3Ak9sCT89klKy+xWxGPcacB3ymWXpSmgbHWBmwZ81wNF
         6d9A==
X-Gm-Message-State: AOAM531nixP/yL0A7pjfFItxJ+tLcxvAgMnRvq349zH1mGWA91QTmfHx
        I5E0WNEQekP9pivLwsrEMaiV8/uJxM7SLQ==
X-Google-Smtp-Source: ABdhPJwHPe3JsM0+lWKAQYZr+lPG4GoBXLN0NAUINjIBrReKRwMxwob+snx9wA9rlAD/v/Epl7+uPA==
X-Received: by 2002:a62:7885:0:b029:300:9a33:1720 with SMTP id t127-20020a6278850000b02903009a331720mr12359279pfc.68.1624656007088;
        Fri, 25 Jun 2021 14:20:07 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id u24sm6928782pfm.200.2021.06.25.14.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 14:20:06 -0700 (PDT)
Date:   Fri, 25 Jun 2021 14:20:05 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager late cleanups for 5.14-rc1
Message-ID: <YNZIhWJGeRwaqRfd@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git/ tags/fpga-cleanup-late-for-5.14

for you to fetch changes up to 92c5ddbc93abddab737df19655787ca354a3a397:

  fpga: fpga-bridge: removed repeated word (2021-05-28 15:09:50 -0700)

----------------------------------------------------------------
FPGA Manager Changes for 5.14-rc1

FPGA Manager
- Navin's change removes a duplicate word in a comment
- Tom's change fixes a spelling mistake
- Mauro's change fixes up documentation

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues
for a couple of weeks.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Mauro Carvalho Chehab (1):
      docs: driver-api: fpga: avoid using UTF-8 chars

Navin Sankar Velliangiri (1):
      fpga: fpga-bridge: removed repeated word

Tom Rix (1):
      fpga: fix spelling mistakes

 Documentation/driver-api/fpga/fpga-bridge.rst      | 10 +++++-----
 Documentation/driver-api/fpga/fpga-mgr.rst         | 12 ++++++------
 Documentation/driver-api/fpga/fpga-programming.rst |  8 ++++----
 Documentation/driver-api/fpga/fpga-region.rst      | 20 ++++++++++----------
 Documentation/fpga/dfl.rst                         |  4 ++--
 drivers/fpga/altera-cvp.c                          |  2 +-
 drivers/fpga/dfl-fme-pr.c                          |  2 +-
 drivers/fpga/dfl-n3000-nios.c                      |  2 +-
 drivers/fpga/dfl.h                                 |  2 +-
 drivers/fpga/fpga-bridge.c                         |  8 ++++----
 drivers/fpga/zynq-fpga.c                           |  6 +++---
 include/linux/fpga/fpga-mgr.h                      |  2 +-
 12 files changed, 39 insertions(+), 39 deletions(-)
