Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBE3425EF
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Mar 2021 20:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCSTOL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Mar 2021 15:14:11 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:33453 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSTNm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 19 Mar 2021 15:13:42 -0400
Received: by mail-pg1-f180.google.com with SMTP id r17so4341946pgi.0
        for <linux-fpga@vger.kernel.org>; Fri, 19 Mar 2021 12:13:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Poqpif1pMoejV53RiA2w1v8foq4NW2FMmOgDZoJXLCI=;
        b=qbdu90hNeDTF647t3YRljBzV8+jHJ8BDgsvSNUj01b3S097j4rdn1yjWCjlOmL32dH
         0+9/8RTCrNJdF+E/FDqWvq6BTpxL8tyQ3u8apqALDo7cSQpOsmEzIq6lbAGuk8Ng0TcH
         U6KDr20o7rBvkrUweN/+q1vOU80VLmBXeBrThsiETJy/rjg6qEFcpBfHzaEkpaCeResY
         jPi53Hwh8MIvFH3CBvUxyfpFONahwsICyREwtckMGl6IYmDW5wDMtlVN+XXzZ5uShcIo
         BskkR/JH8KGFIxveZGmu2veopM96y4/1+sGHVoKW+7QEmtFI4Ac15zm3vn8gPRcuulBU
         ixQw==
X-Gm-Message-State: AOAM533gh3WjnLkbzeOEjuNQ8I+9zmFdhssP744duJeqA3bpngYeyN9A
        J8BPl/TKb/qY2L4tZStIqmY=
X-Google-Smtp-Source: ABdhPJx8E3Yf6eJth/BPELi2ptQW6fCGDUISlOOSU01z/aqHtmJ3mKwgCJHeLYQ0LjEcnkjlW3S/hA==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr12637842pgk.61.1616181210865;
        Fri, 19 Mar 2021 12:13:30 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id 184sm3174323pgd.63.2021.03.19.12.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 12:13:29 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:13:26 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] First set of FPGA Manager changes for 5.13-rc1
Message-ID: <YFT31lF36GipRKte@archbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.13

for you to fetch changes up to 6f1e376cfc6864a2f46538db909bbd5253c3c146:

  fpga: Add support for Xilinx DFX AXI Shutdown manager (2021-03-06 07:54:40 -0800)

----------------------------------------------------------------
First set of FPGA Manager changes for 5.13-rc1

This is the first set of changes for the FPGA Manager 5.13-rc1
mergewindow.

FPGA manager:
- Luca improves error handling using dev_err_probe() for the Xilinx SPI FPGA
  manager.

FPGA bridge:
- Michal simplifies error path using dev_err_probe() for xilinx-pr-decoupler
- Nava adds support (binding + driver code) for Xilinx DFX shutdown manager
  to existing xilinx-pr-decoupler driver

All patches have been reviewed on the mailing list, and have been in the
last linux-next releases (as part of my for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Luca Ceresoli (1):
      fpga: fpga-mgr: xilinx-spi: fix error messages on -EPROBE_DEFER

Michal Simek (1):
      fpga: xilinx-pr-decoupler: Simplify code by using dev_err_probe()

Nava kishore Manne (2):
      dt-bindings: fpga: Add compatible value for Xilinx DFX AXI shutdown manager
      fpga: Add support for Xilinx DFX AXI Shutdown manager

 .../bindings/fpga/xilinx-pr-decoupler.txt          | 24 +++++++++++-
 drivers/fpga/Kconfig                               |  9 ++++-
 drivers/fpga/xilinx-pr-decoupler.c                 | 45 +++++++++++++++++-----
 drivers/fpga/xilinx-spi.c                          | 24 +++++-------
 4 files changed, 75 insertions(+), 27 deletions(-)
