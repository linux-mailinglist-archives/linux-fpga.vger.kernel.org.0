Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC43A269C54
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Sep 2020 05:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgIODKR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 23:10:17 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:33810 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIODKQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 23:10:16 -0400
Received: by mail-pj1-f68.google.com with SMTP id s14so2063822pju.1;
        Mon, 14 Sep 2020 20:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iHHK/vIPRe4VGbzppgzurMm+aOZ71NYl/GkxjI5q/Kc=;
        b=DM8F36jVptpQQvRnRTF049sZf6srt2YLICGJLnEFCpmyKT0OPgoJoUpwLSORd8/5yw
         MADsX9NkI3L4eMR0BKo8moZUTh0p3AD6AbWPNy4LFPl5TJX6/EWfHhxH7VlltjCGdNwW
         WFxSIsIsXvQMbi3FrX/GxuiVl2T5Kk2xskqTb0R3IPKRxPCZjoysTxg8AYaS2OsiTnJR
         4mNenazs4vZDucmefNtxlfY8kyVRgzafRFljqw3Iau0UY/puk9n84P6vM05V3bKR0xGz
         kU59Aver5nb8PUeegnwOG2OMaT0qRxKNANnUZJbx4sgNdPhpNaj0r+MBwdg0zMmv0sPQ
         gpsQ==
X-Gm-Message-State: AOAM531g3w8t3XmSFHxZkpdDvnmSJYFkPC3Nq7k5mhUbL+N4fUkQmiJ4
        iXs8OB3ogPemdfLClwiytB0=
X-Google-Smtp-Source: ABdhPJzeanVCtCHwgE+VS3kGdIDiaF3z2Go55+S5rlhEykyzDF1evHk9FpT6qE6xRff6XinaYuLl5w==
X-Received: by 2002:a17:902:7896:b029:d0:89f1:9e33 with SMTP id q22-20020a1709027896b02900d089f19e33mr17445664pll.15.1600139415392;
        Mon, 14 Sep 2020 20:10:15 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id gl17sm10604107pjb.49.2020.09.14.20.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:10:14 -0700 (PDT)
Date:   Mon, 14 Sep 2020 20:10:14 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH 1/3] fpga: dfl: move dfl_device_id to mod_devicetable.h
Message-ID: <20200915031014.GB1827@epycbox.lan>
References: <1599544129-17594-1-git-send-email-yilun.xu@intel.com>
 <1599544129-17594-2-git-send-email-yilun.xu@intel.com>
 <aaa2d9a5-f5ae-d026-91c9-730403f04050@redhat.com>
 <20200910084106.GB16318@yilunxu-OptiPlex-7050>
 <ad9ba1cf-e02f-c09e-f639-2df60f080e5f@redhat.com>
 <DM6PR11MB3819E2EA499781899B7384F385240@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200914213232.GA1040@epycbox.lan>
 <20200915025516.GB9950@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915025516.GB9950@yilunxu-OptiPlex-7050>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Sep 15, 2020 at 10:55:17AM +0800, Xu Yilun wrote:
> On Mon, Sep 14, 2020 at 02:32:32PM -0700, Moritz Fischer wrote:
> > Hao,
> > 
> > On Fri, Sep 11, 2020 at 06:50:18AM +0000, Wu, Hao wrote:
> > > > On 9/10/20 1:41 AM, Xu Yilun wrote:
> > > > > On Wed, Sep 09, 2020 at 05:55:33AM -0700, Tom Rix wrote:
> > > > >> On 9/7/20 10:48 PM, Xu Yilun wrote:
> > > > >>> In order to support MODULE_DEVICE_TABLE() for dfl device driver, this
> > > > >>> patch moves struct dfl_device_id to mod_devicetable.h
> > > > >>>
> > > > >>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > > >>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > > >>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > > >>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > >>> ---
> > > > >>>  drivers/fpga/dfl.h              | 13 +------------
> > > > >>>  include/linux/mod_devicetable.h | 12 ++++++++++++
> > > > >>>  2 files changed, 13 insertions(+), 12 deletions(-)
> > > > >>>
> > > > >>> diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
> > > > >>> index 5dc758f..d5b0760 100644
> > > > >>> --- a/drivers/fpga/dfl.h
> > > > >>> +++ b/drivers/fpga/dfl.h
> > > > >>> @@ -26,6 +26,7 @@
> > > > >>>  #include <linux/slab.h>
> > > > >>>  #include <linux/uuid.h>
> > > > >>>  #include <linux/fpga/fpga-region.h>
> > > > >>> +#include <linux/mod_devicetable.h>
> > > 
> > > Please fix the order for the new one, other places to good to me.
> > > Acked-by: Wu Hao <hao.wu@intel.com>  for DFL related changes after this fix.
> > 
> > Do you mean the order of the includes, like alphabeticized? If it's
> > minor I can fix it up when applying.
> 
> I think it is the alphabetic of head files. I could sent v2 patchset for
> this fix as well as other fixes.

Alright, works for me. Can you do that?

- Moritz
