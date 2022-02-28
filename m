Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477B44C63F0
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Feb 2022 08:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiB1Hos (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Feb 2022 02:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbiB1Hos (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 28 Feb 2022 02:44:48 -0500
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F966AFA
        for <linux-fpga@vger.kernel.org>; Sun, 27 Feb 2022 23:44:10 -0800 (PST)
Received: by mail-pj1-f52.google.com with SMTP id m22so10419207pja.0
        for <linux-fpga@vger.kernel.org>; Sun, 27 Feb 2022 23:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POhT70x9IVhVvizJwmk5xZBq8U0hZMoSV2Vjr0Yog5I=;
        b=azhhz3uVWBXOgUzLk/USJbVoSi8UNrMzoGsk6T2ZF997lmBdnhqcywJTVnVPNVDfZ6
         EmZnceDewOoIAtdtB5+NoeKiTPiVXc/1ZdsS7W7YyPsmeSqwJpQn0ZNa1XdODHOgQzhu
         UJyyfh06XPtgNONbmyQSaNYFyjU+fSfnQ9df82qawdneK9di1FnZ0CDbiRODu2IFoDIP
         cgzrcdCNUbUuI+unl1guU+6rdaH2N7Kpfw1HuJP80BVoZmVSVQ3xLyijmz6kYrJ1jJKD
         JfWO4yByNbC9RM4fPdLqZVjZ/1tfhlR2mgTFNZ1MTYWej4thv9t1+fa/i5RLyLdL8gco
         R3bQ==
X-Gm-Message-State: AOAM530WspYYfE1o9d0/7J5nkHPlbVtbwv9L3dfCROf/zPNMD/PVwTkJ
        zOvuMtByF9+Toj0F4DNEM7M=
X-Google-Smtp-Source: ABdhPJxZCbSMFagf6dpxlYK1Up2YKsp2FYBxxLHvQpDEWI3XmFSY/S2gv5LamBvLYN4vq1zlcqwlvw==
X-Received: by 2002:a17:90b:702:b0:1bc:6d8a:70e0 with SMTP id s2-20020a17090b070200b001bc6d8a70e0mr15268687pjz.137.1646034249443;
        Sun, 27 Feb 2022 23:44:09 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090ad81300b001bc447c2c91sm16074945pjv.31.2022.02.27.23.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 23:44:08 -0800 (PST)
Date:   Sun, 27 Feb 2022 23:44:07 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Subject: Re: [GIT PULL] FPGA Manager change for 5.18-rc1
Message-ID: <Yhx9R+OJ/Q3pwKi5@archbook>
References: <Yhv2DnIMuYrleRJK@archbook>
 <YhxUgMvs2XabozMF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhxUgMvs2XabozMF@kroah.com>
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

On Mon, Feb 28, 2022 at 05:50:08AM +0100, Greg KH wrote:
> On Sun, Feb 27, 2022 at 02:07:10PM -0800, Moritz Fischer wrote:
> > The following changes since commit 21f0a239ecab4b6765269af78904512358beb802:
> > 
> >   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1
> > 
> > for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:
> > 
> >   fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)
> > 
> > ----------------------------------------------------------------
> > FPGA Manager changes for 5.18-rc1
> > 
> > Christophe's patch is part of a larger effort of removing the use of the
> > deprecated pci-dma-compat API.
> > 
> > All patches have been reviewed on the mailing list, and have been in the
> > last few linux-next releases (as part of our for-next branch) without issues.
> > 
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > 
> > ----------------------------------------------------------------
> 
> No diffstat?

Ugh, yeah. Turns out there's no diff between fpga-for-5.18-rc1 and
fpga-for-5.18-rc1.

I can re-send ... 

Should've read like this:

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git tags/fpga-for-5.18-rc1

for you to fetch changes up to 21f0a239ecab4b6765269af78904512358beb802:

  fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API (2022-01-25 11:25:50 -0800)

----------------------------------------------------------------
FPGA Manager changes for 5.18-rc1

Christophe's patch is part of a larger effort of removing the use of the
deprecated pci-dma-compat API.

All patches have been reviewed on the mailing list, and have been in the
last few linux-next releases (as part of our for-next branch) without issues.

Signed-off-by: Moritz Fischer <mdf@kernel.org>

----------------------------------------------------------------
Christophe JAILLET (1):
      fpga: dfl: pci: Remove usage of the deprecated "pci-dma-compat.h" API

 drivers/fpga/dfl-pci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)
