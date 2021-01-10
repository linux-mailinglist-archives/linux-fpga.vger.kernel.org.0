Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B62F0947
	for <lists+linux-fpga@lfdr.de>; Sun, 10 Jan 2021 20:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbhAJTHx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fpga@lfdr.de>); Sun, 10 Jan 2021 14:07:53 -0500
Received: from mail-pj1-f42.google.com ([209.85.216.42]:38073 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbhAJTHw (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 10 Jan 2021 14:07:52 -0500
Received: by mail-pj1-f42.google.com with SMTP id j13so9132269pjz.3;
        Sun, 10 Jan 2021 11:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k1CYh/swb5bsuB+XDT26cyf6UdnhECIQnDokqGPXw6Q=;
        b=JDdpCUQRCxGWf9Bl2aD3rrXWcjMWfGo/8qzYdvc6tIW47o02v7NNpnrzodEyVNInOR
         Et6ozF49aUcEivJtyIKRKfKGbG3qKubEZbrSXw9oGUV+TZK0vVFl5VQ/xZ5JS5YzOYeW
         lOJw5vWr7QYxpwb6QJb19OvfYwZBbbQEInCUwIMrkLkNZ9zlP5/np8dqcfjdd/YxGRJk
         TPHY4MmPxSsgVhbatuP4QO/QbZJOvlLIECsW6LWXryHns57tIS83kkSFlnzWeWHxCP2s
         bEANEg1eahz1jSBzX3S1IDh8xph1m9222a20o4YstYchsA91ZIIMwDWjKI+gT16drbLk
         H1+w==
X-Gm-Message-State: AOAM530lJNlLGp14VtPJiKI3YKR6+OIFw5MOsn8H66bGE42WgFl20W/Y
        046s9ZrpE9GrKpvJIlQm9VE=
X-Google-Smtp-Source: ABdhPJxsWKwCCPVs62Hiepf+Fq18lcz58iLAeYHPcr2zKS1ayVRPZCb9+8W+EjpeiaSyPALBLrwjxg==
X-Received: by 2002:a17:90b:3d3:: with SMTP id go19mr13717860pjb.201.1610305632252;
        Sun, 10 Jan 2021 11:07:12 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id q15sm16484883pgk.11.2021.01.10.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 11:07:11 -0800 (PST)
Date:   Sun, 10 Jan 2021 11:07:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fpga: Use DEFINE_SPINLOCK() for spinlock
Message-ID: <X/tQXoXxx9JqUZ+g@archbook>
References: <20201228135135.28788-1-zhengyongjun3@huawei.com>
 <58fed6b1-dbab-7696-1086-c8d84cff0379@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <58fed6b1-dbab-7696-1086-c8d84cff0379@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jan 09, 2021 at 02:08:53PM -0800, Tom Rix wrote:
> 
> On 12/28/20 5:51 AM, Zheng Yongjun wrote:
> > spinlock can be initialized automatically with DEFINE_SPINLOCK()
> > rather than explicitly calling spin_lock_init().
> >
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> This looks fine.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> > ---
> >  drivers/fpga/fpga-bridge.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> > index 2deccacc3aa7..e9266b2a357f 100644
> > --- a/drivers/fpga/fpga-bridge.c
> > +++ b/drivers/fpga/fpga-bridge.c
> > @@ -17,7 +17,7 @@ static DEFINE_IDA(fpga_bridge_ida);
> >  static struct class *fpga_bridge_class;
> >  
> >  /* Lock for adding/removing bridges to linked lists*/
> > -static spinlock_t bridge_list_lock;
> > +static DEFINE_SPINLOCK(bridge_list_lock);
> >  
> >  /**
> >   * fpga_bridge_enable - Enable transactions on the bridge
> > @@ -479,8 +479,6 @@ static void fpga_bridge_dev_release(struct device *dev)
> >  
> >  static int __init fpga_bridge_dev_init(void)
> >  {
> > -	spin_lock_init(&bridge_list_lock);
> > -
> >  	fpga_bridge_class = class_create(THIS_MODULE, "fpga_bridge");
> >  	if (IS_ERR(fpga_bridge_class))
> >  		return PTR_ERR(fpga_bridge_class);
> 

Applied,

Thanks
