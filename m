Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E46634837E
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 22:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhCXVSy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 17:18:54 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:45628 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhCXVSv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 24 Mar 2021 17:18:51 -0400
Received: by mail-pj1-f44.google.com with SMTP id kr3-20020a17090b4903b02900c096fc01deso24150pjb.4;
        Wed, 24 Mar 2021 14:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7uEcEQcGd9DID82dc3J2JnCkttWzlorSElofSVje6So=;
        b=M7xG8c4z068jlvHtJ9cdB6ixsAj6MIz4Xv4UcTORRnEhumkCpoZ+xEcqGKW9od++YN
         vQbSJmU0eH/OsxmvLM8hLLG5Eh0jpbpeqGZVguEcYJjwZ4JlSKkEkcK+GmXc4FuoLEe3
         /BdOOUo5A6q1YlfXOFMi35cZ7Rw8CXSuFusnA8zQ72n/+tcqIvIU/GlYi0kR53J30OUI
         pHo7UzGvrEcwUoUPKmlGzmDN+cr4AwbfrFHKEtbkN/C6PWaZKIkaOsNrqjgNWlDeSgjs
         brr2VSqwpk1NFKyM4rRrHC4weUC+PBi88LCFI1RRbIMEm4H2JyJMGLGtdeKaakbZ/xaI
         f3Wg==
X-Gm-Message-State: AOAM532CEpkTPgiPrJ76vyU70bT32affi/vt2nttdJZR4Lea8j5W4+L5
        1x+G+mKf73vJwt9BbbE4EpTe7qVHrB4=
X-Google-Smtp-Source: ABdhPJw1rgkGoxtrSIiVZpmGlG7v5sNipw9QTG++lHhgwXXaUi816Rp6j+SQ2+11AKqYuAl3qv26Fg==
X-Received: by 2002:a17:90a:bb02:: with SMTP id u2mr5475413pjr.175.1616620730785;
        Wed, 24 Mar 2021 14:18:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id t16sm3445348pfc.204.2021.03.24.14.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 14:17:59 -0700 (PDT)
Date:   Wed, 24 Mar 2021 14:17:08 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v12 0/2] UIO support for dfl devices
Message-ID: <YFusVCzSlqNJoOYW@epycbox.lan>
References: <1615168776-8553-1-git-send-email-yilun.xu@intel.com>
 <20210324082217.GA405791@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324082217.GA405791@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Xu,

On Wed, Mar 24, 2021 at 04:22:17PM +0800, Xu Yilun wrote:
> Hi Moritz:
> 
> Sorry I need to get back to you again, seems no more comments from Greg.
> 
> The patchset is stuck here for more than 1 month. Do you have some
> more suggestion that could make it move forward? Do you have some more
> comments? Or give an acked-by? Or could you apply it to your fpga branch
> and go with next pull request?

In its current form it's a UIO driver and needs at least Greg's Acked-by
before I could apply it.

Greg, can you take another look?

> 
> Thanks,
> Yilun
> 
> On Mon, Mar 08, 2021 at 09:59:34AM +0800, Xu Yilun wrote:
> > This patchset supports some dfl device drivers written in userspace.
> > 
> > There are some Q&A about why UIO driver is needed in v11:
> > 
> > >From Greg:
> >   Why are you saying that an ethernet driver should be using the UIO
> >   interface?
> > 
> >   And why can't you use the existing UIO drivers that bind to memory
> >   regions specified by firmware?  Without an interrupt being used, why is
> >   UIO needed at all?
> > 
> > >From Moritz:
> >   Essentially I see two options:
> >   - Have a DFL bus driver instantiate a platform driver (uio_pdrv_genirq)
> >     which I *think* you described above?
> >   - What this patch implements -- a UIO driver on the DFL bus
> > 
> >   These FPGA devices can on the fly change their contents and -- even if
> >   just for test -- being able to expose a bunch of registers via UIO can
> >   be extremely useful.
> > 
> >   Whether a device should expose registers or not should be up to the
> >   implemeneter of the FPGA design I think (policy). This patch (or the
> >   previous version) provides a mechanism to do so via DFL.
> > 
> >   This is similar in nature to uio_pdrv_genirq on a DT based platform, to
> >   expose the registers you instantiate the DT node.
> > 
> >   Re-implementing a new driver for each of these instances doesn't seem
> >   desirable and tying DFL as enumeration mechanism to UIO seems like a
> >   good compromise for enabling this kind of functionality.
> > 
> >   Note this is *not* an attempt to bypass the network stack or other
> >   existing subsystems.
> > 
> > See the original message in:
> >   https://lore.kernel.org/linux-fpga/YDvQ8aO8v3NhLKzx@epycbox.lan/T/#m66ba2c96848e3dea38d1a4f16dfea3cb291f7975
> > 
> > 
> > >From Yilun:
> >   The ETH GROUP IP is not designed as the full functional ethernet
> >   controller. It is specially developed for the Intel N3000 NIC. Since it
> >   is an FPGA based card, it is designed for the users to runtime reload
> >   part of the MAC layer logic developed by themselves, while the ETH GROUP
> >   is another part of the MAC which is not expected to be reloaded by
> >   customers, but it provides some configurations for software to work with
> >   the user logic.
> > 
> >   So I category the feature as the devices that "designed for specific
> >   purposes and does not fit into one of the standard kernel subsystems".
> >   Some related description could be found in Patch #2, to illustrate why
> >   using UIO for some DFL devices.
> > 
> >   There are now UIO drivers for PCI or platform devices, but in this case
> >   we are going to export a DFL(Device Feature List) bus device to
> >   userspace, a DFL driver for UIO is needed to bind to it.
> > 
> > See the original message in:
> >   https://lore.kernel.org/linux-fpga/YDvQ8aO8v3NhLKzx@epycbox.lan/T/#m91b303fd61485644353fad1e1e9c11d528844684
> > 
> > 
> > Xu Yilun (2):
> >   uio: uio_dfl: add userspace i/o driver for DFL bus
> >   Documentation: fpga: dfl: Add description for DFL UIO support
> > 
> >  Documentation/fpga/dfl.rst | 26 ++++++++++++++++++
> >  MAINTAINERS                |  1 +
> >  drivers/uio/Kconfig        | 17 ++++++++++++
> >  drivers/uio/Makefile       |  1 +
> >  drivers/uio/uio_dfl.c      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 111 insertions(+)
> >  create mode 100644 drivers/uio/uio_dfl.c
> > 
> > -- 
> > 2.7.4

Thanks,
Moritz
