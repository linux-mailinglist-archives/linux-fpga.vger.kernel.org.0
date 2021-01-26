Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0B630515E
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbhA0EpZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:25 -0500
Received: from mail-pf1-f172.google.com ([209.85.210.172]:34419 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730077AbhAZE6o (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 25 Jan 2021 23:58:44 -0500
Received: by mail-pf1-f172.google.com with SMTP id m6so9824919pfk.1;
        Mon, 25 Jan 2021 20:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMQSXSqdqPw2ouePc311mhljsHLmSTms1OySVvrYkrQ=;
        b=I+uZOgjBknJKnVv8jzUyqSxTeoyK4u8DpRXLT0a+EH2dbMbOkH+9Vwqz8TcJypsZJ2
         lLhwy3gPayzHyKtlCVIPIcVKzbwL3g4SdtCn62xEAidhWOXlP0cYd1inxN8oRTMy1H6u
         FErVteYQSqVZ429J0hZk9kkZz08oYtIgXOQHxo16m9pEO4qS8Od8rzrnQxUcKFhnFsbh
         6chtOiVW+9N9II3vBRuOeXc+KqLj4AsYRiP9zXWpjDqU7iMTZ0cVGnArU12Sp5517pdD
         v91blbPpXoZecb4VGaf5BgiRJDjndug7rWiEpHOv10dN4J8Jh44kvJ7L1okMNP3Egxxp
         lCxA==
X-Gm-Message-State: AOAM532uTn9Pg/voGXayv2AlzFPgFCOIPwCDVOW2DSUgsvly+dZBluBm
        /tyUEzRemay92QHPY0M4SD4=
X-Google-Smtp-Source: ABdhPJzXL22joUj3DpEtTOenQ7xjmtwixqwQ1eHOi0Q+A458V511AYfdTWKvgRGjrMVBVwT7NTDqyw==
X-Received: by 2002:a62:37c7:0:b029:1aa:22ea:537d with SMTP id e190-20020a6237c70000b02901aa22ea537dmr3680475pfa.56.1611637079026;
        Mon, 25 Jan 2021 20:57:59 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bk18sm908042pjb.41.2021.01.25.20.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:57:58 -0800 (PST)
Date:   Mon, 25 Jan 2021 20:57:57 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v9 1/2] uio: uio_dfl: add userspace i/o driver for DFL bus
Message-ID: <YA+hVZzbAI56NQPT@epycbox.lan>
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-2-git-send-email-yilun.xu@intel.com>
 <e9bb1ff8-f630-f1a3-985c-7e51369a733f@redhat.com>
 <YA98/8r+yOCurHAJ@epycbox.lan>
 <20210126024005.GB3907@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126024005.GB3907@yilunxu-OptiPlex-7050>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 26, 2021 at 10:40:05AM +0800, Xu Yilun wrote:
> On Mon, Jan 25, 2021 at 06:22:55PM -0800, Moritz Fischer wrote:
> > On Mon, Jan 25, 2021 at 11:00:38AM -0800, Tom Rix wrote:
> > > 
> > > On 1/25/21 12:49 AM, Xu Yilun wrote:
> > > > This patch supports the DFL drivers be written in userspace. This is
> > > > realized by exposing the userspace I/O device interfaces.
> > > >
> > > > The driver now only binds the ether group feature, which has no irq. So
> > > > the irq support is not implemented yet.
> > > >
> > > > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > ---
> > > > v9: switch to add a uio driver in drivers/uio
> > > > ---
> > > >  drivers/uio/Kconfig   | 13 ++++++++++
> > > >  drivers/uio/Makefile  |  1 +
> > > >  drivers/uio/uio_dfl.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
> > > 
> > > You should add this to the MAINTAINERS file.
> > 
> > This is covered by MAINTAINERS under drivers/uio.
> 
> Yes. But is it OK I also add the file in "FPGA DFL DRIVERS"? So DFL
> developers would also be aware if there is change. It is a little
> different from other feature driver, it is like a generic driver for
> DFL bus.
Fair enough. I meant you don't have to if you don't want to. If you want
to feel free to do so :)
> 
> > > 
> > > >  3 files changed, 80 insertions(+)
> > > >  create mode 100644 drivers/uio/uio_dfl.c
> > > >
> > > > diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> > > > index 202ee81..44778f8 100644
> > > > --- a/drivers/uio/Kconfig
> > > > +++ b/drivers/uio/Kconfig
> > > > @@ -165,4 +165,17 @@ config UIO_HV_GENERIC
> > > >  	  to network and storage devices from userspace.
> > > >  
> > > >  	  If you compile this as a module, it will be called uio_hv_generic.
> > > > +
> > > > +config UIO_DFL
> > > > +	tristate "Generic driver for DFL bus"
> > > 
> > > The term 'DFL' will be unknown to folks in drivers/uio
> > > 
> > > I think it would be better if DFL was always prefixed 'FPGA DFL'
> > > 
> > > > +	depends on FPGA_DFL
> > > > +	help
> > > > +	  Generic DFL (Device Feature List) driver for Userspace I/O devices.
> > > > +	  It is useful to provide direct access to DFL devices from userspace.
> > > > +	  A sample userspace application using this driver is available for
> > > > +	  download in a git repository:
> > > > +
> > > > +	    git clone https://github.com/OPAE/opae-sdk.git
> > > > +
> > > > +	  If you compile this as a module, it will be called uio_dfl.
> > 
> > I'm not sure KConfig is the right place for this.
> 
> Do you mean the OPAE link? I see several uio drivers provide their
> userspace application link in Kconfig. I guess the uio drivers are
> selected for these applications so it may be better pointing out where
> they are.

Ok, works for me.

- Moritz
