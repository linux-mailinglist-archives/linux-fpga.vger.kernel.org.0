Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D4624AD98
	for <lists+linux-fpga@lfdr.de>; Thu, 20 Aug 2020 06:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgHTEOd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Aug 2020 00:14:33 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54514 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgHTEOd (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 20 Aug 2020 00:14:33 -0400
Received: by mail-pj1-f66.google.com with SMTP id mt12so409494pjb.4;
        Wed, 19 Aug 2020 21:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dolm/iiv9kHl7yL+jwDM3baHrUdsFpOy8LBNCG8NQgs=;
        b=GSnSmJJwbsBBy6H5d/5Ptve8EPqysepB48AbLwN2WWtqLJhokhQjnPbyUrrNnsgUea
         oufUt528rbDwHzos1yAJKJEmI6wdgJXwj8riCnzjlIHOu7cTNOGttYA42+lfdl3nZN4N
         9vPAKbjxXeGapHmnnmWOMFE1CTeIG8xZH9ZXkFNEBuh3Ds7YCAvlO9r+Oziop7ycrVK7
         znq7dgOjSEThrrAbiv60PKH4T7IOSC6GBAsiy8xePvRHe3tSeIvpEDr+Fg89Nn7Sh5Qh
         Vcxr/LDhFYfh+AmM1jiygI1lKdDgMrIvvB7+6tN+eRt4JF88ZEC0LJlakMJtnXaKTnT5
         z3Qw==
X-Gm-Message-State: AOAM531VPA0BElbUcxz47g7LI+lgpkqAQnnWbyTNr8cCgubg6VtGF03k
        f2yCBpM4Hh2/y9huQyLIQRXU+APORLE=
X-Google-Smtp-Source: ABdhPJzyNHpKacPuEn4G7Cxu4KIFAHsG+FSCmAm1LeboxGokieGnrQe0anAgfx8+b3LTrY4WaAwXsw==
X-Received: by 2002:a17:902:780f:: with SMTP id p15mr1251129pll.56.1597896872689;
        Wed, 19 Aug 2020 21:14:32 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z1sm520492pjn.34.2020.08.19.21.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:14:32 -0700 (PDT)
Date:   Wed, 19 Aug 2020 21:14:31 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Moritz Fischer' <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Subject: Re: [PATCH v4 1/4] fpga: dfl: change data type of feature id to u16
Message-ID: <20200820041431.GB4022@epycbox.lan>
References: <1597027273-25288-1-git-send-email-yilun.xu@intel.com>
 <1597027273-25288-2-git-send-email-yilun.xu@intel.com>
 <20200812035604.GA2544@epycbox.lan>
 <3810fb75b42e45928a39a97449a01520@AcuMS.aculab.com>
 <20200813075843.GB7383@yilunxu-OptiPlex-7050>
 <54216e492cec4f84bc43dee176130e89@AcuMS.aculab.com>
 <20200813090409.GA1080@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813090409.GA1080@yilunxu-OptiPlex-7050>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:09PM +0800, Xu Yilun wrote:
> On Thu, Aug 13, 2020 at 08:28:05AM +0000, David Laight wrote:
> > From: Xu Yilun
> > > Sent: 13 August 2020 08:59
> > > On Wed, Aug 12, 2020 at 08:52:39AM +0000, David Laight wrote:
> > > > From: Moritz Fischer
> > > > > Sent: 12 August 2020 04:56
> > > > >
> > > > > On Mon, Aug 10, 2020 at 10:41:10AM +0800, Xu Yilun wrote:
> > > > > > The feature id is stored in a 12 bit field in DFH. So a u16 variable is
> > > > > > enough for feature id.
> > > > > >
> > > > > > This patch changes all feature id related places to fit u16.
> > > >
> > > > How much bigger does it make the kernel?
> > > 
> > > The patch changes the definition of feature id from u64 to u16, and will
> > > make the kernel slightly smaller.
> > 
> > Unlikely.
> > Most of the structures will gain a 'pad' field.
> > Using u16 for function parameters and results almost certainly
> > requires instructions to mask the value.
> > Any arithmetic on u16 will require masking instructions on
> > (probably) all architectures except x86.
> > 
> > Using 'unsigned int' is probably best.
> > 
> > u16 is never a good idea unless you are defining enough
> > of them in a structure (eg as an array) to reduce the
> > structure size below some threshold.
> > (Or are matching some hardware layout.)
> 
> I got it. Thanks for your detailed explanation. I think we may change them to
> u32. Is it the same case for u8? Think we may also change the dfl_device_id.type.
> 
> 
> Hi Moritz:
> 
> The patch is applied to for-next, is it possible we recall it, or we
> make another fix after it?
> 
> Thanks,
> Yilun.

Sorry for the delay, can you send a follow-up please?

Cheers,
Moritz
