Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E2F21B9CA
	for <lists+linux-fpga@lfdr.de>; Fri, 10 Jul 2020 17:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGJPqT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 10 Jul 2020 11:46:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37495 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJPqT (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 10 Jul 2020 11:46:19 -0400
Received: by mail-pf1-f195.google.com with SMTP id s26so2707990pfm.4;
        Fri, 10 Jul 2020 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yhTtJRTJXOvcoXVeEriil9VP131no0hEgltA/Dirf4w=;
        b=sFdnvmQpyiIRigGTtkAokRm67w1E+0OjAeXUUC6q+imb7MlHMDYT1lXRx+o2HL/wC3
         eMJuSUNd/jBOqQQ1IBzrwcPj2ev82fQYfS48Dv4g9sRreGz2bE8bnr+OOiXJVItXJpEd
         o+0RpecNglrwhYh322QxykIrjGftGs25l8wsspqZUVaZOgspwDgati6x9Cz5yVp2WsCQ
         iaGJH+sATzM0H1kh4zZ1KmnaMCWpInPmvteRSnQkpuVlnvTdg5hRkCyUpl5m1WRl4ljj
         dZPO31tLjJstJIsQSPVnMVuxmsKrHdmvnadyacWwcfKiSitidSekKywB2siI6OTo7jdX
         v8Ug==
X-Gm-Message-State: AOAM533i4G110HG+jVRYzd6H4KQektO7CgmmO6bSLigoZIqTz3H/9JQ7
        60hXK5AAxCuKhnL5i4i7q0Q=
X-Google-Smtp-Source: ABdhPJxNBJS20J2XnwaWY7SBoEH0afToq2nuqUFeImqSskMnzcdKItU72mJCXWho82jrh2RBs74ctA==
X-Received: by 2002:aa7:930b:: with SMTP id 11mr60057545pfj.320.1594395978749;
        Fri, 10 Jul 2020 08:46:18 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id c27sm6130825pfj.163.2020.07.10.08.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 08:46:18 -0700 (PDT)
Date:   Fri, 10 Jul 2020 08:46:16 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     "Wu, Hao" <hao.wu@intel.com>
Cc:     "Xu, Yilun" <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        "Weight, Russell H" <russell.h.weight@intel.com>
Subject: Re: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
Message-ID: <20200710154616.GA130068@epycbox.lan>
References: <1594282705-32289-1-git-send-email-yilun.xu@intel.com>
 <DM6PR11MB3819117029F124067F7EA8B985640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <20200709093527.GA32541@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819D07348C347B5BB8F86C085640@DM6PR11MB3819.namprd11.prod.outlook.com>
 <2d7919d5-a320-58f4-5c9d-7ef868ad8676@redhat.com>
 <20200710052443.GB8689@yilunxu-OptiPlex-7050>
 <DM6PR11MB3819BF1B54D64AD706BF832E85650@DM6PR11MB3819.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3819BF1B54D64AD706BF832E85650@DM6PR11MB3819.namprd11.prod.outlook.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 10, 2020 at 06:14:19AM +0000, Wu, Hao wrote:
> > On Thu, Jul 09, 2020 at 06:00:40AM -0700, Tom Rix wrote:
> > >
> > > On 7/9/20 3:14 AM, Wu, Hao wrote:
> > > >> On Thu, Jul 09, 2020 at 05:10:49PM +0800, Wu, Hao wrote:
> > > >>>> Subject: [PATCH] fpga: dfl: pci: add device id for Intel FPGA PAC N3000
> > > >>>>
> > > >>>> Add PCIe Device ID for Intel FPGA PAC N3000.
> > > >>>>
> > > >>>> Signed-off-by: Wu Hao <hao.wu@intel.com>
> > > >>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > > >>>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > > >>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > >>>> ---
> > > >>>>  drivers/fpga/dfl-pci.c | 2 ++
> > > >>>>  1 file changed, 2 insertions(+)
> > > >>>>
> > > >>>> diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
> > > >>>> index 73b5153..824aecf 100644
> > > >>>> --- a/drivers/fpga/dfl-pci.c
> > > >>>> +++ b/drivers/fpga/dfl-pci.c
> > > >>>> @@ -64,6 +64,7 @@ static void cci_pci_free_irq(struct pci_dev
> > *pcidev)
> > > >>>>  #define PCIE_DEVICE_ID_PF_INT_5_X0xBCBD
> > > >>>>  #define PCIE_DEVICE_ID_PF_INT_6_X0xBCC0
> > > >>>>  #define PCIE_DEVICE_ID_PF_DSC_1_X0x09C4
> > > >>>> +#define PCIE_DEVICE_ID_PF_PAC_N3000 0x0B30
> > > >>> Should we drop _PF_ here? and also do you want _INTEL_ here?
> > > >> I think we could keep _PF_, also there is no need to support VF of pac
> > > >> n3000 in product now, but it does exist (ID: 0x0b31).
> > >
> > > I was wondering about the vf id, thanks!
> > >
> > > >>
> > > >> And add _INTEL_ is good to me.
> > > >>
> > > >> Then how about this one:
> > > >>   #define PCIE_DEVICE_ID_PF_INTEL_PAC_N3000	0x0B30
> > > > I am just considering the alignment with ids defined in
> > include/linux/pci_ids.h
> > > > So drop _PF_ before _INTEL_ would be better? : )
> > >
> > > To be consistent, all the id's are intel and all could drop pf.
> > 
> > That's good to me after checking the pci_ids.h. So we have:
> > 
> > #define PCIE_DEVICE_ID_INTEL_PAC_N3000        0x0B30
> 
> Sounds good to me.
> 
> Hao

Heads up I was gonna send out the PR early next week. I can fix this up
myself if you want if you want or you can resend it?

Thanks,
Moritz
