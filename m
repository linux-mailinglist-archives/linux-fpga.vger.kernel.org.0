Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE2323D0A6
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Aug 2020 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgHETvp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Aug 2020 15:51:45 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:50410 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgHETv2 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Aug 2020 15:51:28 -0400
Received: by mail-pj1-f66.google.com with SMTP id e4so5266834pjd.0;
        Wed, 05 Aug 2020 12:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6emjLqhFv6lUP9L7Pmh7/cPih4ItBfkcf8aGfybjT1g=;
        b=Aqa4u7Mlwxf7pSSwQQY6ayO5MmpR60jbjrBqidQFyNczeB3m8wi51HtxSEIQfEyxqg
         Eh6rbK94+uhQnaWzE4P+cEWNiRHgPLVnhiUv2UaXh0//FyaVCMwI/jM2p9s5iPrhGrev
         9m6RWQHSc6+I/PSIrxvab1Bb6e4AqTX1XJBreO0+RH0dM9EIN8c86GuxCxQp84b92Puc
         LlrQqs/dQ2saaOMO9D1CVlGQxMk1anALsby6VM/ITCmYcClwcNUrBWY6mdPYG+gmp2Ty
         TBDXuUVD4FgokQMhGu3ywK2jNSSCS48d9FP7ULh86ZqC1wUX/Cax6vyt3ijQhkysjVId
         HZnw==
X-Gm-Message-State: AOAM5327Ofqa7VVnonjibYlWpNzj/ay0BR9rxMRCqrGEXQnVuSGGykcH
        W4JITyXj5N9Qxl/1UQYKtqE=
X-Google-Smtp-Source: ABdhPJxW5sF6pW3KYLCyWMfpQB82bFtbLDql/G3Tu1uJ4NEJ2sYoQ/T3T/PvHALY0w0D77xXNCN/mg==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr4725311pll.79.1596657087373;
        Wed, 05 Aug 2020 12:51:27 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id bj18sm3878823pjb.5.2020.08.05.12.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 12:51:26 -0700 (PDT)
Date:   Wed, 5 Aug 2020 12:51:25 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
Message-ID: <20200805195125.GA1905851@epycbox.lan>
References: <20200804162003.19402-1-trix@redhat.com>
 <20200804164133.GA1499313@epycbox.lan>
 <DM6PR11MB3819024D3EE4913E0AA97680854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819024D3EE4913E0AA97680854B0@DM6PR11MB3819.namprd11.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Aug 05, 2020 at 07:58:21AM +0000, Wu, Hao wrote:
> > Subject: Re: [PATCH] MAINTAINERS: Add Tom Rix as fpga reviewer
> > 
> > Hi Tom,
> > 
> > On Tue, Aug 04, 2020 at 09:20:03AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > >
> > > I take care of fpga kernel and userspace for Red Hat and would
> > > like help out more with the mainline kernel.
> > >
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ce2737b1feb5..6fdb01776413 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -6805,6 +6805,7 @@ F:	drivers/net/ethernet/nvidia/*
> > >
> > >  FPGA DFL DRIVERS
> > >  M:	Wu Hao <hao.wu@intel.com>
> > > +R:	Tom Rix <trix@redhat.com>
> > >  L:	linux-fpga@vger.kernel.org
> > >  S:	Maintained
> > >  F:	Documentation/fpga/dfl.rst
> > > @@ -6813,6 +6814,7 @@ F:	include/uapi/linux/fpga-dfl.h
> > >
> > >  FPGA MANAGER FRAMEWORK
> > >  M:	Moritz Fischer <mdf@kernel.org>
> > > +R:	Tom Rix <trix@redhat.com>
> > >  L:	linux-fpga@vger.kernel.org
> > >  S:	Maintained
> > >  W:	http://www.rocketboards.org
> > > --
> > > 2.18.1
> > >
> > Acked-by: Moritz Fischer <mdf@kernel.org>
> > 
> > I can take the patch, can I get an Acked-by from Hao?
> 
> Sure. : ) 
> 
> Acked-by: Wu Hao <hao.wu@intel.com>
> 
> Thanks!
> Hao
> 
> > 
> > Thanks!
> > 
> > Moritz

Applied to for-next,

Thanks,
Moritz
