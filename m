Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0414D29E660
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Oct 2020 09:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgJ2I1Q (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Oct 2020 04:27:16 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34943 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgJ2I1P (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Oct 2020 04:27:15 -0400
Received: by mail-vs1-f68.google.com with SMTP id g10so294339vsi.2;
        Thu, 29 Oct 2020 01:27:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=I429XvDB7s491T4RH/UoppaANaaMt+LbyvyurSN1nMI=;
        b=g834rxdoxFNDxUQDFzN5gYoPxsgaWM+Zp12OsIPfkuXV6onX+zmvQr4r2d1OkOmGGK
         OQm0N/tYHC565mcHDsnF4bTdcYt+j1sEGC917cX+KkOYHkY2a+LD77IUpunDZrOXVdsg
         +D+gS3AuGUnvhywtgukdNdqyo+6w4Loacf/ALOz2qz5ylZ+1Paa337z7oNFqRQSs09tV
         8YGBFsIrC38NA0l2hLJjy8SlErBzkDPmdPhNT1gd9jbrVLV0AwmGnEZZC+uJBsjHWaOq
         LLllfuc0iJVa9SsyltCR97aU6E6L7XpVOHsdN48ib5Mddci90QBBVgfBF+OC8PdnKPWL
         CGEA==
X-Gm-Message-State: AOAM533B3OdykiHRSsy6tCvy3e1fIi95thneT9/usCrTz9u2Du6Z2QRq
        lMyg70HUBCowk+e0JPS8I+afhej3gk/seg==
X-Google-Smtp-Source: ABdhPJzstoDYkvX3bxZppyw7GLIukzJZDxwVcPeh6QVF84VDm6nWh+Tq0cVM716Quy0mPPL6yu0b2A==
X-Received: by 2002:aa7:8492:0:b029:155:79b1:437a with SMTP id u18-20020aa784920000b029015579b1437amr2741370pfn.26.1603953348375;
        Wed, 28 Oct 2020 23:35:48 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id q8sm1708550pff.18.2020.10.28.23.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 23:35:47 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:35:46 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/7] fpga: sec-mgr: intel fpga security manager class
 driver
Message-ID: <20201029063546.GB20665@archbook>
References: <20201021001650.13978-1-russell.h.weight@intel.com>
 <20201021001650.13978-2-russell.h.weight@intel.com>
 <DM6PR11MB3819FE25626E8ECC308A666385190@DM6PR11MB3819.namprd11.prod.outlook.com>
 <10bef8d1-7abf-d8f9-008c-5e13fc75c088@intel.com>
 <DM6PR11MB3819F79EC96A7B285C2BB99585170@DM6PR11MB3819.namprd11.prod.outlook.com>
 <10ed6cda-fb82-4663-0956-c7019ec49837@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10ed6cda-fb82-4663-0956-c7019ec49837@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Russ,

On Wed, Oct 28, 2020 at 11:37:46AM -0700, Russ Weight wrote:
> 
> 
> On 10/27/20 7:41 PM, Wu, Hao wrote:
> >> On 10/25/20 7:29 PM, Wu, Hao wrote:
> >>>> Subject: [PATCH v5 1/7] fpga: sec-mgr: intel fpga security manager class
> >>>> driver
> >>>>
> >>>> Create the FPGA Security Manager class driver. The security
> >>>> manager provides interfaces to manage secure updates for the
> >>>> FPGA and BMC images that are stored in FLASH. The driver can
> >>>> also be used to update root entry hashes and to cancel code
> >>>> signing keys.
> >>>>
> >>>> This patch creates the class driver and provides sysfs
> >>>> interfaces for displaying root entry hashes, canceled code
> >>>> signing keys and flash counts.
> >>>>
> >>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >>>> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> >>>> Reviewed-by: Tom Rix <trix@redhat.com>
> >>>> ---
> >>>> v5:
> >>>>   - Added the devm_fpga_sec_mgr_unregister() function, following recent
> >>>>     changes to the fpga_manager() implementation.
> >>>>   - Changed some *_show() functions to use sysfs_emit() instead of
> >> sprintf(
> >>>> v4:
> >>>>   - Changed from "Intel FPGA Security Manager" to FPGA Security
> >> Manager"
> >>>>     and removed unnecessary references to "Intel".
> >>>>   - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> >>>> v3:
> >>>>   - Modified sysfs handler check in check_sysfs_handler() to make
> >>>>     it more readable.
> >>>> v2:
> >>>>   - Bumped documentation dates and versions
> >>>>   - Added Documentation/fpga/ifpga-sec-mgr.rst
> >>>>   - Removed references to bmc_flash_count & smbus_flash_count (not
> >>>> supported)
> >>>>   - Split ifpga_sec_mgr_register() into create() and register() functions
> >>>>   - Added devm_ifpga_sec_mgr_create()
> >>>>   - Removed typedefs for imgr ops
> >>>> ---
> >>>>  .../ABI/testing/sysfs-class-fpga-sec-mgr      |  67 +++
> >>>>  Documentation/fpga/fpga-sec-mgr.rst           |  50 ++
> >>>>  Documentation/fpga/index.rst                  |   1 +
> >>>>  MAINTAINERS                                   |   9 +
> >>>>  drivers/fpga/Kconfig                          |   9 +
> >>>>  drivers/fpga/Makefile                         |   3 +
> >>>>  drivers/fpga/fpga-sec-mgr.c                   | 487 ++++++++++++++++++
> >>>>  include/linux/fpga/fpga-sec-mgr.h             |  83 +++
> >>>>  8 files changed, 709 insertions(+)
> >>>>  create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>>>  create mode 100644 Documentation/fpga/fpga-sec-mgr.rst
> >>>>  create mode 100644 drivers/fpga/fpga-sec-mgr.c
> >>>>  create mode 100644 include/linux/fpga/fpga-sec-mgr.h
> >>>>
> >>>> diff --git a/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>>> b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>>> new file mode 100644
> >>>> index 000000000000..843f0b58f171
> >>>> --- /dev/null
> >>>> +++ b/Documentation/ABI/testing/sysfs-class-fpga-sec-mgr
> >>>> @@ -0,0 +1,67 @@
> >>>> +What: /sys/class/fpga_sec_mgr/fpga_secX/name
> >>>> +Date:Oct 2020
> >>>> +KernelVersion:  5.11
> >>>> +Contact:Russ Weight <russell.h.weight@intel.com>
> >>>> +Description:Name of low level fpga security manager driver.
> >>>> +
> >>>> +What:
> >>>> /sys/class/fpga_sec_mgr/fpga_secX/security/sr_root_entry_hash
> >>>> +Date:Oct 2020
> >>>> +KernelVersion:  5.11
> >>>> +Contact:Russ Weight <russell.h.weight@intel.com>
> >>>> +Description:Read only. Returns the root entry hash for the static
> >>>> +region if one is programmed, else it returns the
> >>>> +string: "hash not programmed".  This file is only
> >>>> +visible if the underlying device supports it.
> >>>> +Format: "0x%x".
> >>>> +
> >>> If we plan to make this class driver a common one for everybody, then
> >>> these sysfs defined here sounds a little device-specific? This is just my
> >>> personal feeling, Moritz and Tom, how do you guys think about these ones?
> >> Yes - this occurred to me as well. The data in the security subdirectory
> >> could be different for different vendors. I'm not sure if this is a problem
> >> or not. One thing to note is that these sysfs entries are only present if there
> >> is a handler for them. Additional, optional, file types could be added by other
> >> vendors.
> > But if other vendors want to have their own ones, they follow the same method.
> > that means every time we need to add more handlers and sysfs entries to this
> > common class driver. This is not what we really want. If we consider this common
> > class driver is one abstraction layer, we would like to have the real common items
> > in such driver. Vendor specific items could be handled in drivers provided by
> > the different vendors but not in the common file, at least we don't want to touch
> > it every time. How do you think?
> It isn't a generic interface if every vendor has to extend the number of sysfs
> entries supported by the class device - but if the total number of vendors is
> two, then maybe it isn't an issue? I'm really not sure what the number would be...
> 
> Looking through sysfs, I can also see a number stats files (e.g.
> /sys/fs/xfs/stats/stats) that contain multiple lines of information. There are
> also meminfo files (e.g. /sys/devices/system/node/node1/meminfo) that contain
> multiple lines of information.
> 
> All of the information in the security/ directory is read-only information. Would
> it be reasonable to replace the security directory with a single secinfo file that
> contains name/value pairs that describe the data? For example:
> 
> bmc_canceled_csks:
> bmc_root_entry_hash: 0x16609930bf6e65ee0d929a87884c37826a731bb317a11f4feb47b3cb328b9b0c
> pr_canceled_csks:
> pr_root_entry_hash: hash not programmed
> sr_canceled_csks:
> sr_root_entry_hash: 0xa74b1b31b6b010e94be4a3a043f9af3c5b81258893fbe40cd91d8441fb1cb827
> user_flash_count: 113
> 
> If we did that, then the format could be enforced as an array of name/value string
> pairs, which could vary by device/vendor. It would be human readable. Any parser
> would have to know what device and format it was dealing with.
> 
> I think the options we have are:
> (1) Extend the support sysfs entries as needed (the current implementation)
> (2) Provide a single secinfo (or security_info) file that enforces name/value pairs
> (3) Move the security information out of the class driver. The scope of the class
>     driver would be the update only.
> 
> If (2) is acceptable, then I like that best. I think (3) is also OK. I am uncertain
> about (1).

I'm not a fan of (1). Not sure about (2) in terms of what people do with
sysfs, if it's just readonly it might be fine, (3) seems reasonable to me.

Cheers,
Moritz
