Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 714452697BB
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 23:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgINVch (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 17:32:37 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37541 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgINVcg (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 17:32:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id w7so666392pfi.4;
        Mon, 14 Sep 2020 14:32:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxPkXhqlAFVkhBlcdAangH+5G5NOYVoOkH633FrRrJM=;
        b=LSU5wCcQV3AIRcBPq5tO7BcB6RnUP/Na6BgwBhnWafBS7T9fphrqgX5yUHGU1H5a/j
         ZMqqvJlJ+X42NUpOeYq0iCHIP85F1rbRog6fIGiwmQuHZyDFu0po2MWahF8k+tT0UUHT
         ILYPAfuXo862NuEjVzGn6ZBhcIfhxDAoFsrFQ+5STdgGoMdU1w86wMulcV59unus9ASL
         XNfE+epISqeCDtnGchvSu7AkP7rRWQcCo969XVH2LZG2tPW1D1NRo137YjT2zgbPFsyj
         4H7a3cGsvo5Jja8ZF0KoTJ1+WJTAWxgyv3SarnPTwKFCx/sxgB5AxznNfZ1iS02UWGgO
         OgpQ==
X-Gm-Message-State: AOAM5303zYIZS/j3QytfNYEZJB3jjo2zsx/RWRoTrOE1BRIliAPCtQPh
        J4Or3hURuyHl4CJHd9akQ0c=
X-Google-Smtp-Source: ABdhPJxWp+umJLT77yalayofcGiM3KtEpRnsJ8b5unXVtulF3tO6PepWq9IA7NWnyIwqUcaeAqDJ/A==
X-Received: by 2002:aa7:9dd2:0:b029:13e:d13d:a109 with SMTP id g18-20020aa79dd20000b029013ed13da109mr14628525pfq.37.1600119155199;
        Mon, 14 Sep 2020 14:32:35 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id i15sm4620056pfk.145.2020.09.14.14.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:32:34 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:32:32 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     Tom Rix <trix@redhat.com>, "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200914213232.GA1040@epycbox.lan>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
 <20200910084106.GB16318@yilunxu-OptiPlex-7050>
 <ad9ba1cf-e02f-c09e-f639-2df60f080e5f@redhat.com>
 <DM6PR11MB3819E2EA499781899B7384F385240@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819E2EA499781899B7384F385240@DM6PR11MB3819.namprd11.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hao,

On Fri, Sep 11, 2020 at 06:50:18AM +0000, Wu, Hao wrote:
> > On 9/10/20 1:41 AM, Xu Yilun wrote:
> > > On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
> > >> On 9/7/20 10:48 PM, Xu Yilun wrote:
> > >>> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > >>> patch moves struct dfl_device_id to mod_devicetable.h
> > >>>
> > >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > >>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > >>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > >>> ---
> > >>>  drivers/fpga/dfl.h              | 13 +------------
> > >>>  include/linux/mod_devicetable.h | 12 ++++++++++++
> > >>>  2 files changed, 13 insertions(+), 12 deletions(-)
> > >>>
> > >>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > >>> index 5dc758f..d5b0760 100644
> > >>> --- a/drivers/fpga/dfl.h
> > >>> +++ b/drivers/fpga/dfl.h
> > >>> @@ -26,6 +26,7 @@
> > >>>  #include <linux/slab.h>
> > >>>  #include <linux/uuid.h>
> > >>>  #include <linux/fpga/fpga-region.h>
> > >>> +#include <linux/mod_devicetable.h>
> 
> Please fix the order for the new one, other places to good to me.
> Acked-by: Wu Hao <hao.wu@intel.com>  for DFL related changes after this fix.

Do you mean the order of the includes, like alphabeticized? If it's
minor I can fix it up when applying.

Thanks,
Moritz
