Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD793AAA70
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Jun 2021 06:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhFQEpm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Jun 2021 00:45:42 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:46696 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhFQEpl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Jun 2021 00:45:41 -0400
Received: by mail-pg1-f176.google.com with SMTP id n12so3876264pgs.13;
        Wed, 16 Jun 2021 21:43:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ER3Bi6TVKIRud7DpBpxLSpXeMQufYCROiIwToeMbm+g=;
        b=B+lZxfVzW2SYsBfb2hEDPuc6nBo+8ycQflAOLONRybyIX/s9UuPBEMqeWA6TOQU5lU
         g7fcCkNegawtqoovelCQDkDSMicyPFCj1T9JMiSEIE0egGn9p+AaErpdu6MZ8UWEghBA
         sqxGkJsQ9BWD4vD3Zfj3r+63RSEGhzSRzJy0kFKGYnKpe7UzOeZ2wkFAdjVvu8/pWqWW
         h5uyY74ask8BJJtQDeBvYv2PSMoSq98y+M9Ym07AhB9NTpe/StvCFfnCjkOUIICutaXW
         i6YgW4XGyybJpEyFvsB8SCGiGWtDd7dsd9u8b0EAU+UJ1G974T7XL70V4JvSur5d6Pd1
         KzoQ==
X-Gm-Message-State: AOAM532mIGtUfwB/3vsvxA+0ad5R7TgW8S6ZsjUn15TQnXUEogaoy6vk
        ES4ujvxNtDNlsyqjJ+8Wl8o=
X-Google-Smtp-Source: ABdhPJztcpfwm5nNoeBnKE0CupxSIL8mRtJz17LReIOn+Gr1e7h7Rf/6ig2So/BP+WLWGWoF7QJH+A==
X-Received: by 2002:a65:52cb:: with SMTP id z11mr3146184pgp.201.1623905014537;
        Wed, 16 Jun 2021 21:43:34 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id j15sm3590350pjn.28.2021.06.16.21.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:43:33 -0700 (PDT)
Date:   Wed, 16 Jun 2021 21:43:32 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Message-ID: <YMrS9OUSaCdtGwrE@epycbox.lan>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
 <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
 <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jun 16, 2021 at 01:05:36AM +0000, Wu, Hao wrote:
> > On 6/15/21 1:08 AM, Wu, Hao wrote:
> > >> Subject: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
> > >>
> > >> From: Tom Rix <trix@redhat.com>
> > >>
> > >> Follow drivers/net/ethernet/ which has control configs
> > >> NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> > >> Since fpgas do not have many vendors, drop the 'VENDOR' and use
> > >> FPGA_BLA.
> > > Hi Tom,
> > >
> > > Thanks for this patch. : )
> > >
> > > DFL is not a vendor, but something can be shared/reused. It's possible that
> > > other vendors reuse the same concepts and the drivers of DFL. If vendor
> > > drivers need to be moved inside sub folders, then maybe it's better to
> > > leave DFL in the parent folder?
> > 
> > xrt is also not a vendor, more a subdevice framework like dfl.
> > 
> > I am not sure what you mean by other dfl vendors can you give an example ?
> 
> It's fine, but the description here is a little confusing on vendor/framework
> handling. No other vendor so far, but it's possible, DFL can be used in 
> non-intel device, and related drivers can be reused as well. Then a fpga 
> mgr driver depends on DFL, should be put inside dfl folder or new
> vendor's subfolder?
> 
> Hao
> 

I'm somewhat neutral on this. If someone non-intel starts using DFL we could also
move the common parts back ...

That being said, I'm not super convinced we have to move stuff in the
first place.

- Moritz
