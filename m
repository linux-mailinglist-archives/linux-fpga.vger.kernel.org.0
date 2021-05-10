Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B61379645
	for <lists+linux-fpga@lfdr.de>; Mon, 10 May 2021 19:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbhEJRpM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 May 2021 13:45:12 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:41842 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbhEJRpL (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 May 2021 13:45:11 -0400
Received: by mail-pg1-f182.google.com with SMTP id m37so13833765pgb.8;
        Mon, 10 May 2021 10:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s5lmK1+OZLwxBU1OoSI15fp+aIvsLBGSfbw/McbfXvs=;
        b=WKOtZoH0g4qNrr+g+dFULr6AGm++R4xByY3LKbf3Jo7h1Q+fW3eKNUOOtC6POZYtgL
         wGZCHJVGebQeOLybqejryRqYpadyM9wq7r0v9ACsGXJHXn7oo4NsVBVO7qKmOXrPLYyn
         EMME/hFZcYpEMS7kSGDNMkPTxLjgGwhd1VG32h6hc5ARitDIOlLS+xYLv/LjHPwtLMiQ
         n4tC9La2UoMzAAiZMWaMeY4FtukbfKIl/weoLW1LWcph56k4jyDA55Er9ZIVkGaZSKDO
         Pdt28z2uo5jr7/zzIs7hDOpZWb9TQ9WWLDw7oI/cTWAC8heV6MGTV2g65j8nuf9J0wA/
         mV5Q==
X-Gm-Message-State: AOAM53181N0USQ0v87gveft5sSaEcoyngYeDBjxQaZe3YeAsfsBL0rAX
        ob66GaFrN0/KvmzvJlhnigRkSsmUX9QWAw==
X-Google-Smtp-Source: ABdhPJw1Ep+d8PgXoQHvR+7kiCh1SLIFNgftTmuA/rMKH27jgP9UTxB7p8JfQv142Lj38pLDQJ9Xrg==
X-Received: by 2002:a62:ea10:0:b029:25a:9902:43f3 with SMTP id t16-20020a62ea100000b029025a990243f3mr26075477pfh.68.1620668646731;
        Mon, 10 May 2021 10:44:06 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 33sm11538907pgq.21.2021.05.10.10.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 10:44:06 -0700 (PDT)
Date:   Mon, 10 May 2021 10:44:05 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <navam@xilinx.com>
Cc:     Moritz Fischer <mdf@kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Michal Simek <michals@xilinx.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "chinnikishore369@gmail.com" <chinnikishore369@gmail.com>
Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Message-ID: <YJlw5fk0ORhioDb4@epycbox.lan>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
 <YApf1jlEghbnDFo/@archbook>
 <MWHPR02MB2623B63A5359BB35B89BF086C2BB9@MWHPR02MB2623.namprd02.prod.outlook.com>
 <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN6PR02MB2612733F9D85ED6A36BBF801C2989@BN6PR02MB2612.namprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Mar 03, 2021 at 10:11:51AM +0000, Nava kishore Manne wrote:
> Ping!
> 
> > -----Original Message-----
> > From: Nava kishore Manne
> > Sent: Wednesday, January 27, 2021 2:43 PM
> > To: Moritz Fischer <mdf@kernel.org>
> > Cc: trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; git <git@xilinx.com>; chinnikishore369@gmail.com
> > Subject: RE: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
> > 
> > Hi Moritz,
> > 
> > 	Thanks for the review.
> > Please find my response inline.
> > 
> > > -----Original Message-----
> > > From: Moritz Fischer <mdf@kernel.org>
> > > Sent: Friday, January 22, 2021 10:47 AM
> > > To: Nava kishore Manne <navam@xilinx.com>
> > > Cc: mdf@kernel.org; trix@redhat.com; robh+dt@kernel.org; Michal Simek
> > > <michals@xilinx.com>; linux-fpga@vger.kernel.org;
> > > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > > linux- kernel@vger.kernel.org; git <git@xilinx.com>;
> > > chinnikishore369@gmail.com
> > > Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading
> > > support
> > >
> > > On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> > > > This commit adds secure flags to the framework to support secure
> > > > BitStream Loading.
> > > >
> > > > Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> > > > ---
> > > >  drivers/fpga/of-fpga-region.c | 10 ++++++++++
> > > > include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
> > > >  2 files changed, 22 insertions(+)
> > > >
> > > > diff --git a/drivers/fpga/of-fpga-region.c
> > > > b/drivers/fpga/of-fpga-region.c index e405309baadc..3a5eb4808888
> > > > 100644
> > > > --- a/drivers/fpga/of-fpga-region.c
> > > > +++ b/drivers/fpga/of-fpga-region.c
> > > > @@ -228,6 +228,16 @@ static struct fpga_image_info
> > > *of_fpga_region_parse_ov(
> > > >  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
> > > >  		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
> > > >
> > > > +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-
> > > config"))
> > > > +		info->flags |=
> > > FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;
> > >
> > > Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> > 
> > In Encryption we have two kinds of use case one is Encrypted Bitstream
> > loading with Device-key and Other one is Encrypted Bitstream loading with
> > User-key. To differentiate both the use cases this Changes are needed.
> > 
> > Regards,
> > Navakishore.

Is this region specific, or could this be a sysfs attribute?

- Moritz
