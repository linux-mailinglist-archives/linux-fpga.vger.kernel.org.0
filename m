Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A230F3D5173
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Jul 2021 05:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhGZCUY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 25 Jul 2021 22:20:24 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37544 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhGZCUX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 25 Jul 2021 22:20:23 -0400
Received: by mail-pl1-f182.google.com with SMTP id n10so10036253plf.4
        for <linux-fpga@vger.kernel.org>; Sun, 25 Jul 2021 20:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NVpzxpX1UiRE7wTFrX1B+vcQvQ1bCCyiizenhYk2Q+k=;
        b=goMwdbm9M3mvQdmUKWQicCeAXBjhZclwnOi3nc5UT9w9271LT59Wo6xvKXNMDohdgt
         J1eqyomupxz1dpnZpr+aH97GjDT58nWSxP5S6OYc/1jEIorwHZ8ajqkiUVM73QIn7RRQ
         d+2Ru8I2XEBzWhfxCSbICCWxWa9fZU4af3XwWZV2Xi2ZPZZiXiJAqfovxQ6+tYizxSuR
         HuX47q9c1sGjocghict2qZoRbKHVRvvOEBOTybq4JP8TI8DFbLRW7858UnYpIlpO3ii7
         QtSWJiBe+MK80U4N0uRQcOSJ/N0Ac539Otew0U7vRo9pSt4SeyWF5sWCXXOrMf/0jwpq
         TFIw==
X-Gm-Message-State: AOAM530zoXMuFlvOkrs/LxaUfH8mAq9yzEKVLEh0tK/hLvKokJQYjbKt
        h1PI409meV6yaMFgMRTxj7o=
X-Google-Smtp-Source: ABdhPJymXQRlfULV5+5F3WSXu/FS5uCU9Uzyirn+bnO/OxMvK+qrbdMR+GWMdb7sd7p70xjy4Y+FPw==
X-Received: by 2002:a62:c501:0:b029:32a:dfe9:8648 with SMTP id j1-20020a62c5010000b029032adfe98648mr16049972pfg.28.1627268451256;
        Sun, 25 Jul 2021 20:00:51 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id g71sm16917654pfb.139.2021.07.25.20.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jul 2021 20:00:50 -0700 (PDT)
Date:   Sun, 25 Jul 2021 20:00:49 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager changes for 5.15-rc1
Message-ID: <YP4lYQAedSyF2zAe@epycbox.lan>
References: <YP4kHpn7CDzCYrbU@epycbox.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YP4kHpn7CDzCYrbU@epycbox.lan>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Greg,

On Sun, Jul 25, 2021 at 07:55:26PM -0700, Moritz Fischer wrote:
> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga tags/fpga-for-5.15
> 
> for you to fetch changes up to c485d3bf3cc7790faed2b90c799a38caa2f69268:
> 
>   fpga: fpga-mgr: wrap the write_sg() op (2021-07-18 08:05:00 -0700)
> 
> ----------------------------------------------------------------
> FPGA Manager Changes for 5.15-rc1
> 
> FPGA Manager
> 
> - Navin's change removes a duplicate word in a comment
> - Tom's change fixes a spelling mistake
> - Mauro's change fixes up documentation
> - Tom's second set adds wrappers to allow drivers not having to
>   implement empty functions by moving checks into fpga-mgr core code
> - My changes address a bunch of warnings
> 
> DFL
> 
> - Martin's change adds a new PCI ID for Silicom N501x PAC cards
> 
> All patches have been reviewed on the mailing list, and have been in the
> last linux-next releases (as part of my for-next branch).
> 
> I did get a complaint about one of the commit messages w/ a Fixes: tag
> which would need a rebase to fix.
> 
> Some of the earlier patches were originally meant for 5.14 but missed
> the merge window by a couple of days, hence the back-merge of 5.14-rc1.
> 
> Signed-offy-by: Moritz Fischer <mdf@kernel.org>
> 
> ----------------------------------------------------------------
> Martin Hundebøll (1):
>       fpga: dfl: pci: add device IDs for Silicom N501x PAC cards
> 
> Mauro Carvalho Chehab (1):
>       docs: driver-api: fpga: avoid using UTF-8 chars
> 
> Moritz Fischer (5):
>       Merge tag 'v5.14-rc1' into for-next
>       fpga: altera-freeze-bridge: Address warning about unused variable
>       fpga: xiilnx-spi: Address warning about unused variable
>       fpga: xilinx-pr-decoupler: Address warning about unused variable
>       fpga: zynqmp-fpga: Address warning about unused variable
> 
> Navin Sankar Velliangiri (1):
>       fpga: fpga-bridge: removed repeated word
> 
> Tom Rix (8):
>       fpga: fix spelling mistakes
>       fpga: fpga-mgr: wrap the write_init() op
>       fpga: fpga-mgr: make write_complete() op optional
>       fpga: fpga-mgr: wrap the write() op
>       fpga: fpga-mgr: wrap the status() op
>       fpga: fpga-mgr: wrap the state() op
>       fpga: fpga-mgr: wrap the fpga_remove() op
>       fpga: fpga-mgr: wrap the write_sg() op
> 
>  Documentation/driver-api/fpga/fpga-bridge.rst      |  10 +-
>  Documentation/driver-api/fpga/fpga-mgr.rst         |  12 +--
>  Documentation/driver-api/fpga/fpga-programming.rst |   8 +-
>  Documentation/driver-api/fpga/fpga-region.rst      |  20 ++--
>  Documentation/fpga/dfl.rst                         |   4 +-
>  drivers/fpga/altera-cvp.c                          |   2 +-
>  drivers/fpga/altera-freeze-bridge.c                |   2 +
>  drivers/fpga/dfl-fme-mgr.c                         |   6 --
>  drivers/fpga/dfl-fme-pr.c                          |   2 +-
>  drivers/fpga/dfl-n3000-nios.c                      |   2 +-
>  drivers/fpga/dfl-pci.c                             |   5 +
>  drivers/fpga/dfl.h                                 |   2 +-
>  drivers/fpga/fpga-bridge.c                         |   8 +-
>  drivers/fpga/fpga-mgr.c                            | 111 ++++++++++++++-------
>  drivers/fpga/stratix10-soc.c                       |   6 --
>  drivers/fpga/ts73xx-fpga.c                         |   6 --
>  drivers/fpga/xilinx-pr-decoupler.c                 |   2 +
>  drivers/fpga/xilinx-spi.c                          |   2 +
>  drivers/fpga/zynq-fpga.c                           |   6 +-
>  drivers/fpga/zynqmp-fpga.c                         |  10 +-
>  include/linux/fpga/fpga-mgr.h                      |   2 +-
>  21 files changed, 127 insertions(+), 101 deletions(-)

I realize the backwards merge is somewhat messy, as discussed you said
to not rebase.

Alternatively there's a tag (fpga-for-5.15-early) with the changes
rebased onto v5.14-rc1 that also addresses the 'Fixes: ' tag.

If you pull that instead then I could just merge that tag into my
for-next branch and linux-next should be fine again.

When I localy tried it seemed to resolve fine with merge either of the
branches involved (linux-next/master, char-misc-next, for-next).

- Moritz
