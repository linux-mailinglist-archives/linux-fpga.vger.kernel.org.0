Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7F2D7B99F
	for <lists+linux-fpga@lfdr.de>; Wed, 31 Jul 2019 08:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbfGaG00 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 31 Jul 2019 02:26:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33591 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfGaG0Z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 31 Jul 2019 02:26:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so22179844pgj.0
        for <linux-fpga@vger.kernel.org>; Tue, 30 Jul 2019 23:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HAOLv596ncbzrxFqsd5j/5xyKL5UaQEyvWTJoC/mZ44=;
        b=NwVBMl17fhCNf5C+q8AyDXqOYvINZYWJxgGgPqJLNoG4b3h+rwX35ANAy6J81PH3WS
         6RSombD8inngtd074ICxpzmbBi6vBwPTAdp6GTjAbn9zNzwMLWGForFkYx59a5AVvyZZ
         nxIal9bf0/wCleAJZZRIs7dAm7mA9hsrjMyPwLrz94hb9DqHu6QLFARkH/etZf/Nx+u8
         H1sOQvBArPo3RCNNv+LNr30tEe6xWE9HkmXVLP8CKcBkZXTts3bWSFVP30Bu9geIwqQF
         4WnhkrLZFSDI1a4wcNkmFkETklEI41AGhJbgkW89nX5rI3bEwLmI2xBZRnN43r6xURd1
         vP/w==
X-Gm-Message-State: APjAAAWFRL/wP3V5y1Wn6n+Lo4gddE9SFzu4fCckj7H3MTaEsGBKPR0R
        8y96IK3lvsb76NeKqEFBTCh+RQ==
X-Google-Smtp-Source: APXvYqwDsSubnNZNyJ4UIWSL8jTDvtUjH2IsV9rDHBvTWREnA0QhTeTktmXz4xrWr1N3323jQKOdnA==
X-Received: by 2002:a63:fd57:: with SMTP id m23mr47036013pgj.204.1564554384881;
        Tue, 30 Jul 2019 23:26:24 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:1bdd:d748:9a4e:8083])
        by smtp.gmail.com with ESMTPSA id q126sm23915950pfb.56.2019.07.30.23.26.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 23:26:23 -0700 (PDT)
Date:   Tue, 30 Jul 2019 23:26:22 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        broonie@kernel.org
Subject: [GIT PULL] Please pull FPGA Manager changes for 5.4
Message-ID: <20190731062622.GA4414@archbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.4

for you to fetch changes up to 2949dc443116a66fd1a92d9ef107be16cdd197cd:

  dt-bindings: fpga: Consolidate bridge properties (2019-07-24 14:19:15 -0700)

----------------------------------------------------------------
FPGA Manager changes for 5.4-rc1

Here is the first set of changes for the 5.4-rc1 merge window.

They're all more or less cleanup patches:

- Carlos' patch addresses a checkpatch warning
- My first patch changes the return type of a function to align it with
  the fact that nothing checks the return value and it uncoditionally
  returned 0 anyways
- My second patch somehow fell through the cracks before and cleans up
  the FPGA bridge bindings by consolidating them instead of repeating
  the same paragraph over and over again.

All of these patches have been in the last few linux-next releases
without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Carlos A Petry (1):
      fpga: altera-cvp: Fix function definition argument

Moritz Fischer (2):
      fpga: altera-pr-ip: Make alt_pr_unregister function void
      dt-bindings: fpga: Consolidate bridge properties

 .../devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt   |  5 +----
 .../devicetree/bindings/fpga/altera-freeze-bridge.txt       |  5 +----
 .../devicetree/bindings/fpga/altera-hps2fpga-bridge.txt     |  5 +----
 Documentation/devicetree/bindings/fpga/fpga-bridge.txt      | 13 +++++++++++++
 .../devicetree/bindings/fpga/xilinx-pr-decoupler.txt        |  8 ++------
 drivers/fpga/altera-cvp.c                                   |  3 ++-
 drivers/fpga/altera-pr-ip-core-plat.c                       |  4 +++-
 drivers/fpga/altera-pr-ip-core.c                            |  4 +---
 include/linux/fpga/altera-pr-ip-core.h                      |  2 +-
 9 files changed, 25 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-bridge.txt
