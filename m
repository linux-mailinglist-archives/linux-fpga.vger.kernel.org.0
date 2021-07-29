Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C223DAB5E
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 20:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhG2Svc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 14:51:32 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:36733 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhG2Svc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Jul 2021 14:51:32 -0400
Received: by mail-pj1-f52.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso17136951pjb.1;
        Thu, 29 Jul 2021 11:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tB5r7jCOOPtFx6Q3Xg17uNrYOv0JnsNx/+HyvJ9HcMY=;
        b=Wq5T3tNUCbzAFjmKGUZybPrFiOdbKuj1NpgpeoPIo07SzN1wEDqnZ3Sr5bo95BQmtr
         OmZL7eH4zCyJzF2i4N1MKJ2M7YM0aGaQtqNj6YZyzXzFu4YcKwmpZZS5TRVLklydDySh
         UHtxgvdwbKfPN6QfGiE00e25xoXFHhImhq14dYohXrv7bYokLVIpfk8WGv0Xo31jrCHe
         nRWA7YR1aWJY6az9tcm4ogUtCYG3vZYm/DCV50t2ihMjVVIo9GQ0f9+bQn6PmWC+0wRe
         2B1gcLgz/oqT0OULQMKRufbEl5P7XtyoF36K/44eaOgMIVyypmtZ+aK/FiLtBRV6+KFE
         Q8LQ==
X-Gm-Message-State: AOAM53314o2wz0y9luaOWk2+KwQaMK2BQnkJ9efeV4v3dcYbr13iYadK
        WLnDjhWjPDrWLk/d0Ud2yuQ=
X-Google-Smtp-Source: ABdhPJwS111Y8fetmdxFNjjKDlXVD2Q9U/D66wiGaEpHbEsop7x+AynHKIzIY7ubQ2y77VVIU9YKtA==
X-Received: by 2002:a65:578a:: with SMTP id b10mr5034953pgr.135.1627584687707;
        Thu, 29 Jul 2021 11:51:27 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id r18sm4980703pgk.54.2021.07.29.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 11:51:24 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:51:23 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH] fpga: region: handle compat_id as an uuid
Message-ID: <YQL4qyAmqj322HTz@epycbox.lan>
References: <20210726202650.4074614-1-trix@redhat.com>
 <6f30a4c6-61a0-bb57-9f13-bcad3f3589b8@intel.com>
 <ba28bac6-9c6d-de73-523f-b8ba4bef84de@redhat.com>
 <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB38199F872DC94971D9C8A53885EA9@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jul 28, 2021 at 01:36:56AM +0000, Wu, Hao wrote:
> > On 7/26/21 3:12 PM, Russ Weight wrote:
> > > On 7/26/21 1:26 PM, trix@redhat.com wrote:
> > >> From: Tom Rix <trix@redhat.com>
> > >>
> > >> An fpga region's compat_id is exported by the sysfs
> > >> as a 128 bit hex string formed by concatenating two
> > >> 64 bit values together.
> > >>
> > >> The only user of compat_id is dfl.  Its user library
> > >> opae converts this value into a uuid.
> > >>
> > >> ex/
> > >> $ cat /sys/class/fpga_region/region1/compat_id
> > >> f3c9941350814aadbced07eb84a6d0bb
> > >>
> > >> Is reported as
> > >> $ fpgainfo bmc
> > >> ...
> > >> Pr Interface Id                  : f3c99413-5081-4aad-bced-07eb84a6d0bb
> > >>
> > >> Storing a uuid as 2 64 bit values is vendor specific.
> > >> And concatenating them together is vendor specific.
> > >>
> > >> It is better to store and print out as a vendor neutral uuid.
> > >>
> > >> Change fpga_compat_id from a struct to a union.
> > >> Keep the old 64 bit values for dfl.
> > >> Sysfs output is now
> > >> f3c99413-5081-4aad-bced-07eb84a6d0bb
> > > I'm fowarding feedback from Tim Whisonant, one of the OPAE userspace
> > > developers:
> > >
> > > I think that this change to the sysfs for the compat_id node will
> > > end up breaking the SDK, which does not expect the '-' characters to
> > > be included when parsing the sysfs value. Currently, it is parsed as
> > > a raw hex string without regard to any '-' characters. This goes for
> > > any "guid" currently exported by sysfs and for what we read in the
> > > device MMIO space.
> > 
> > Yes, it will.
> > 
> > And there are other places, like dfl-afu-main.c:afu_id_show()
> > 
> > outputs raw hex that sdk turns into a uuid.
> > 
> > 
> > Some options.
> > 
> > If no one but dfl will ever use it, then v1 of patchset.
> > 
> > If others can use it but don't want to change dfl, then v2 of patchset,
> > my favorite.
> > 
> > Or this one for uuid for everyone, what have been v3 but changed too much.
> > 
> > 
> > could dfl change generally to output uuid's to the sysfs ?
> > 
> > this would be generally helpful and a one time disruption to the sdk.
> 
> This change limited the output format to uuid_t, but if any hardware doesn't
> use uuid_t on hardware may have to convert it back from the sysfs output in
> userspace. Leave it to print hardware values (e.g. from register), and convert
> it in userspace should be fine too I think.

I'm not entirely sure. I seem to recall there being examples of sysfs
files returning different things for different drivers.

That being said it seems largely cosmetic to add the '-' in between.

If it breaks userspace, I'm against it. If you *need* it make a
compat_uuid entry or something in that case?

- Moritz
