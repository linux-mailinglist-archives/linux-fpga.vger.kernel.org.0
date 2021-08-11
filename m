Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4286C3E8F74
	for <lists+linux-fpga@lfdr.de>; Wed, 11 Aug 2021 13:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237273AbhHKL3m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 Aug 2021 07:29:42 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:38402 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbhHKL3l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 11 Aug 2021 07:29:41 -0400
Received: by mail-wm1-f51.google.com with SMTP id i10-20020a05600c354ab029025a0f317abfso4157256wmq.3;
        Wed, 11 Aug 2021 04:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIL3/7PzyH6nx9D3aVENdGNeH/zsOZHpOqb2pn11fKQ=;
        b=QarEf3cosrpgKM0nAGanTDR3bsznil9qrwtxVrEz/wCjkYQaAB8+no5xtZanQ36Y63
         y3C3R2i150GlPAwPKAZeryjuvNmoJetKcSuqJZDGxvqlse3OiVcWPX/R6sEZe8D/kKQu
         IdigcrXuez4eHmG+zfb4362fH0KSWZqbQGGDtY+aeHzbNV5aQd8Xq2SmhkL4ybLW66+f
         yesI9xN+99tG4hhChhaeMK7RhfyPWLfzO80/oRFW4FyjuxX8tU0kSmDradD1ZuLyiDrJ
         qWKeBREUHgIi0IP81eeHTSYOqugUkf1xN1CSdAQ7wyz55p9DtVuQfLltKpZxqMQLUOQ/
         he4Q==
X-Gm-Message-State: AOAM533boCQAGQFFfHgwaKCgDcPz6DYqENhrIRQwZwGXBWlXiA+QQXxL
        eT2SfatfFSzEU7Jq2AEdHag=
X-Google-Smtp-Source: ABdhPJwPwSvnYoXQvnf2p9hhoc7kt4V1UGgGBmb0e3DgHBKWPlXgLtTrsyjaeWHk6K1oYd4f0D+Y2g==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr9345344wmg.35.1628681357390;
        Wed, 11 Aug 2021 04:29:17 -0700 (PDT)
Received: from localhost (HSI-KBW-095-208-000-224.hsi5.kabel-badenwuerttemberg.de. [95.208.0.224])
        by smtp.gmail.com with ESMTPSA id g4sm1476865wrb.18.2021.08.11.04.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 04:29:16 -0700 (PDT)
Date:   Wed, 11 Aug 2021 04:29:15 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, trix@redhat.com,
        mdf@kernel.org, p.pisati@gmail.com, atull@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: machxo2-spi: return an error on failure
Message-ID: <YRO0izb18fMEdxWH@archbook>
References: <20210810164036.922830-1-trix@redhat.com>
 <YRKyAScLKow17mPO@kroah.com>
 <20210810185116.GR22532@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810185116.GR22532@kadam>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Aug 10, 2021 at 09:51:16PM +0300, Dan Carpenter wrote:
> On Tue, Aug 10, 2021 at 07:06:09PM +0200, Greg KH wrote:
> > On Tue, Aug 10, 2021 at 09:40:36AM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Reported problem
> > > 
> > > 	drivers/fpga/machxo2-spi.c:229 machxo2_write_init()
> > > 	warn: missing error code 'ret'
> > > 
> > > 	drivers/fpga/machxo2-spi.c:316 machxo2_write_complete()
> > > 	warn: missing error code 'ret'
> > 
> > What reported this?  What does it mean?  Where was it reported?
> 
> These are Smatch errors, but my bug reports don't mention Smatch so
> that's on me.  I've fixed my report templated to mention Smatch now.
> 
> regards,
> dan carepenter
> 
> 
Applied with slightly reworded commit-message to 'fixes' branch.

Thanks,
Moritz
