Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56AE8410DB4
	for <lists+linux-fpga@lfdr.de>; Mon, 20 Sep 2021 00:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhISXAB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 19 Sep 2021 19:00:01 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:52218 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbhISXAB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 19 Sep 2021 19:00:01 -0400
Received: by mail-pj1-f49.google.com with SMTP id dw14so10673051pjb.1
        for <linux-fpga@vger.kernel.org>; Sun, 19 Sep 2021 15:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ncuQ4NI9VU2H82OU+U0aCwNlJXHZRsMCHBwRI4VBIcA=;
        b=J3DWx81+ZfNqMqLT2rn6/Vr2pPkR25k6EJ+rD4931SWXEfVOcSJCbIe0/ifHRknraZ
         j8eurnxC3Gk25K0RQEun5K4iJRM6fd1xYAs8fdxFTHMdzw9WXP2w3RtQHsLMHqYmDAA6
         0NrQi0lBVSjGUrepaqJnYsusaDAnDsEJB78/A++aXavenAqbYVsQnqBwN/1MgbjEFBqH
         ki2XVkNcjAAZo0PAjvc46o2Kc5Ze7ZcLZoWtrf9JG2SDwYVK0nq6bbzA3AEl6lb98aZD
         kZfaB23+M9vcX8OvMsvohls7tjN1vdQe7pH451aPqPs05U66wLnXviO6OXoIOBsNBH4m
         gfNg==
X-Gm-Message-State: AOAM530tJn133a9QdxYNjmAgbNtIden3uvRjthRNBYfsh4JsNdV/mbt7
        hNToh9ZA/o5e9IVhEVQW/5M=
X-Google-Smtp-Source: ABdhPJyvtWBQtm5YF9zsMK3qlaUox4YM2uWgW7kplVvR2Yb72F6TO8OTt+pPBKiroqVwhZKWUvodXQ==
X-Received: by 2002:a17:90a:c58b:: with SMTP id l11mr25277062pjt.134.1632092315181;
        Sun, 19 Sep 2021 15:58:35 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id 203sm11490169pfx.119.2021.09.19.15.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:58:34 -0700 (PDT)
Date:   Sun, 19 Sep 2021 15:58:31 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com
Subject: [GIT PULL] FPGA Manager fixes for 5.15
Message-ID: <YUfAl+ngbh3GBFHU@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-fixes-5.15

for you to fetch changes up to e9a9970bf520c99e530d8f1fa5b5c22671fad4ef:

  fpga: dfl: Avoid reads to AFU CSRs during enumeration (2021-09-16 15:20:55 -0700)

----------------------------------------------------------------
FPGA Manager fixes for 5.15

Tom and Jiapeng's fixes address smatch warnings around missing return
values in error cases.

Russ' change addresses an issue where registers are being accessed too
early resulting in invalid data being read.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of my fixes branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Jiapeng Chong (1):
      fpga: machxo2-spi: Fix missing error code in machxo2_write_complete()

Russ Weight (1):
      fpga: dfl: Avoid reads to AFU CSRs during enumeration

Tom Rix (1):
      fpga: machxo2-spi: Return an error on failure

 drivers/fpga/dfl.c         | 14 ++++++++------
 drivers/fpga/machxo2-spi.c |  6 +++++-
 2 files changed, 13 insertions(+), 7 deletions(-)
