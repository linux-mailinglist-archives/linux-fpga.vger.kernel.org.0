Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC6E3D857B
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Jul 2021 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbhG1BjG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Jul 2021 21:39:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:52988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234225AbhG1BjG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Jul 2021 21:39:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="192154968"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="192154968"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 18:39:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="517201810"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2021 18:39:03 -0700
Date:   Wed, 28 Jul 2021 09:33:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com, richard.gong@intel.com
Subject: Re: [RESEND PATCH v10 0/3] fpga: Use standard class dev_release
  function
Message-ID: <20210728013318.GA430304@yilunxu-OptiPlex-7050>
References: <20210726212750.121293-1-russell.h.weight@intel.com>
 <39607b02-bad3-0f65-c1c8-efd6036ab4f3@intel.com>
 <661d53d0-0ba4-d344-8da0-995a9b612905@redhat.com>
 <f8c391e2-987a-916a-a0e9-7795f71ec76d@intel.com>
 <8584c933-4482-446a-761c-9a5d511a81c5@redhat.com>
 <add87155-6417-fd08-c3c5-b39e7b9662df@intel.com>
 <c3c17e6e-9a57-eb90-fe00-c442c59ad921@redhat.com>
 <b5519458-af01-43ee-2873-2092d552b060@intel.com>
 <61debd50-c75f-2adb-5465-b9525704e0df@redhat.com>
 <0837a32b-59d4-2ef2-448f-1350f9011a2c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0837a32b-59d4-2ef2-448f-1350f9011a2c@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jul 27, 2021 at 02:07:04PM -0700, Russ Weight wrote:
> 
> 
> On 7/27/21 10:44 AM, Tom Rix wrote:
> >
> > On 7/27/21 10:16 AM, Russ Weight wrote:
> >>
> >> On 7/27/21 9:55 AM, Tom Rix wrote:
> >>> On 7/27/21 9:38 AM, Russ Weight wrote:
> >>>> On 7/27/21 9:22 AM, Tom Rix wrote:
> >>>>> On 7/27/21 9:15 AM, Russ Weight wrote:
> >>>>>> On 7/27/21 6:24 AM, Tom Rix wrote:
> >>>>>>> On 7/26/21 2:33 PM, Russ Weight wrote:
> >>>>>>>> Hi Moritz,
> >>>>>>>>
> >>>>>>>> I sent this version of the patchset out on July 8th. The only discussion has
> >>>>>>>> been around the compat-id structure. I think there is agreement that this can
> >>>>>>>> be treated separately. What are your thoughts? Do you think this patchset is
> >>>>>>>> ready?
> >>>>>>> While I agree the compat_id can be treated separately, i still have a problem with the 2 register functions.
> >>>>>>>
> >>>>>>> In this discussion,
> >>>>>>>
> >>>>>>> https://lore.kernel.org/linux-fpga/DM6PR11MB38194D113950FA4B75C7F2C485E49@DM6PR11MB3819.namprd11.prod.outlook.com/
> >>>>>>>
> >>>>>>> *register_full(..., *info) becomes
> >>>>>>>
> >>>>>>> *register(..., *info)
> >>>>>>>
> >>>>>>> and
> >>>>>>>
> >>>>>>> *register_simple() is moved out of the public api and becomes private to the subsystem.
> >>>>>> Somehow I missed that part of the email. I'm not sure I understand the part about
> >>>>>> register_simple() "becomes private to the subsystem". Most users would call the simple
> >>>>>> version of the API. Is the proposal to replicate the register_simple() interface
> >>>>>> for each driver that calls it?
> >>>>> Still use *register_simple() internally, so most of your patchset is unchanged.
> >>>>>
> >>>>> Move it out the public api. include/linux/fpga-mgr.h into someplace appropriate in drivers/fpga/
> >>>> Ok - I'll do another spin of the patch set.
> >>>>
> >>>> Just to be clear, *register_full() gets renamed back to *register(). The current *register()
> >>>> goes back to *register_simple(). *register_simple() is an exported symbol, but the function
> >>>> prototype moves out of the public header file into private header file under drivers/fpga.
> >>> Mostly.
> >>>
> >>> If register_simple does not need to be exported, it shouldn't be.
> >> If *register_simple() is to reside in the fpga_mgr or fpga_region module and be
> >> called by other modules, then it has to be exported... unless it is defined as a
> >> static function in a header file. Shall I go that route instead? I could create
> >> a new drivers/fpga/fpga.h file and add the *register_simple() functions there.
> >> Or I could create separate drivers/fpga/fpga-mgr.h and drivers/fpga/fpga-region.h
> >> header files with one static function each.

If you should move the *register_simple() out of the public APIs, then
why you need the function?

> >
> > good point, exporting ok
> 
> Before I do this, can I get others to chime in? There was a previous patchset that
> used *register_simple() and *register(). It seemed that the consensus at that time
> was that it should be *register() and *register_full(). I'm starting to feel like
> I'm going in circles...
> 
> I personally don't have a problem with two public flavors of the register function
> (the way it is now), what do other's think? If it really is a problem to have two
> versions of the register function, maybe I should just change all of the callers
> to declare a structure and call the same register function?

I don't have strong perference of one register function or more. There
are some subsystems with register functions and others with more.

In our case, the *register_full/register(dev, info) is necessary. The
*register_simple(dev, ...) is the wrapper to make life easier for some
drivers, so optional. If there is strong concern about the multiple
register APIs, my suggestion is we start with the necessary one.

Thanks,
Yilun

> 
> - Russ
> 
> 
> >
> > Tom
> >
> >>
> >> - Russ
> >>
> >>> Tom
> >>>
> >>>> - Russ
> >>>>
> >>>>> Tom
> >>>>>
> >>>>>>> Tom
> >>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> - Russ
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 7/26/21 2:27 PM, Russ Weight wrote:
> >>>>>>>>> The FPGA framework has a convention of using managed resource functions
> >>>>>>>>> to allow parent drivers to manage the data structures allocated by the
> >>>>>>>>> class drivers. They use an empty *_dev_release() function to satisfy the
> >>>>>>>>> class driver.
> >>>>>>>>>
> >>>>>>>>> This is inconsistent with linux driver model.
> >>>>>>>>>
> >>>>>>>>> These changes remove the managed resource functions and populate the class
> >>>>>>>>> dev_release callback functions. They also merge the create() and register()
> >>>>>>>>> functions into a single register() or register_full() function for each of
> >>>>>>>>> the fpga-mgr, fpga-region, and fpga-bridge class drivers.
> >>>>>>>>>
> >>>>>>>>> The new *register_full() functions accept an info data structure to provide
> >>>>>>>>> flexibility in passing optional parameters. The *register() functions
> >>>>>>>>> support the legacy parameter list for users that don't require the use of
> >>>>>>>>> optional parameters.
> >>>>>>>>>
> >>>>>>>>> For more context, refer to this email thread:
> >>>>>>>>>
> >>>>>>>>> https://marc.info/?l=linux-fpga&m=162127412218557&w=2
> >>>>>>>>>
> >>>>>>>>> I turned on the configs assocated with each of the modified files, but I
> >>>>>>>>> must have been missing some dependencies, because not all of them compiled.
> >>>>>>>>> I did a run-time test specifically with the dfl-fme infrastructure. This
> >>>>>>>>> would have exercised the region, bridge, and fpga-mgr frameworks.
> >>>>>>>>>
> >>>>>>>>> Changelog v9 -> v10:
> >>>>>>>>>       - Fixed commit messages to reference register_full() instead of
> >>>>>>>>>         register_simple().
> >>>>>>>>>       - Removed the fpga_bridge_register_full() function, because there is
> >>>>>>>>>         not need for it yet. Updated the documentation and commit message
> >>>>>>>>>         accordingly.
> >>>>>>>>>       - Updated documentation to reference the fpga_manager_info and
> >>>>>>>>>         fpga_region_info structures.
> >>>>>>>>>
> >>>>>>>>> Changelog v8 -> v9:
> >>>>>>>>>       - Cleaned up documentation for the FPGA Manager, Bridge, and Region
> >>>>>>>>>         register functions
> >>>>>>>>>       - Renamed fpga_*_register() to fpga_*_register_full()
> >>>>>>>>>       - Renamed fpga_*_register_simple() to fpga_*_register()
> >>>>>>>>>       - Renamed devm_fpga_mgr_register() to devm_fpga_mgr_register_full()
> >>>>>>>>>       - Renamed devm_fpga_mgr_register_simple() to devm_fpga_mgr_register()
> >>>>>>>>>
> >>>>>>>>> Changelog v7 -> v8:
> >>>>>>>>>       - Added reviewed-by tags.
> >>>>>>>>>       - Updated Documentation/driver-api/fpga/ files: fpga-mgr.rst,
> >>>>>>>>>         fpga-bridge.rst, and fpga-region.rst.
> >>>>>>>>>
> >>>>>>>>> Changelog v6 -> v7:
> >>>>>>>>>       - Update the commit messages to describe the new parameters for the
> >>>>>>>>>         *register() functions and to mention the *register_simple() functions.
> >>>>>>>>>       - Fix function prototypes in header file to rename dev to parent.
> >>>>>>>>>       - Make use of the PTR_ERR_OR_ZERO() macro when possible.
> >>>>>>>>>       - Some cleanup of comments.
> >>>>>>>>>       - Update function definitions/prototypes to apply const to the new info
> >>>>>>>>>         parameter.
> >>>>>>>>>       - Verify that info->br_ops is non-null in the fpga_bridge_register()
> >>>>>>>>>         function.
> >>>>>>>>>       - Verify a non-null info pointer in the fpga_region_register() function.
> >>>>>>>>>
> >>>>>>>>> Changelog v5 -> v6:
> >>>>>>>>>       - Moved FPGA manager/bridge/region optional parameters out of the ops
> >>>>>>>>>         structure and back into the FPGA class driver structure.
> >>>>>>>>>       - Changed fpga_*_register() function parameters to accept an info data
> >>>>>>>>>         structure to provide flexibility in passing optional parameters.
> >>>>>>>>>       - Added fpga_*_register_simple() functions to support current parameters
> >>>>>>>>>         for users that don't require use of optional parameters.
> >>>>>>>>>
> >>>>>>>>> Changelog v4 -> v5:
> >>>>>>>>>       - Rebased on top of recently accepted patches.
> >>>>>>>>>       - Removed compat_id from the fpga_mgr_register() parameter list
> >>>>>>>>>         and added it to the fpga_manager_ops structure. This also required
> >>>>>>>>>         dynamically allocating the dfl-fme-ops structure in order to add
> >>>>>>>>>         the appropriate compat_id.
> >>>>>>>>>       - Created the fpga_region_ops data structure which is optionally passed
> >>>>>>>>>         to fpga_region_register(). compat_id, the get_bridges() pointer, and
> >>>>>>>>>         the priv pointer are included in the fpga_region_ops structure.
> >>>>>>>>>
> >>>>>>>>> Changelog v3 -> v4:
> >>>>>>>>>       - Added the compat_id parameter to fpga_mgr_register() and
> >>>>>>>>>         devm_fpga_mgr_register() to ensure that the compat_id is set before
> >>>>>>>>>         the device_register() call.
> >>>>>>>>>       - Added the compat_id parameter to fpga_region_register() to ensure
> >>>>>>>>>         that the compat_id is set before the device_register() call.
> >>>>>>>>>       - Modified the dfl_fpga_feature_devs_enumerate() function to restore
> >>>>>>>>>         the fpga_region_register() call to the correct location.
> >>>>>>>>>
> >>>>>>>>> Changelog v2 -> v3:
> >>>>>>>>>       - Cleaned up comment headers for fpga_mgr_register(), fpga_bridge_register(),
> >>>>>>>>>         and fpga_region_register().
> >>>>>>>>>       - Fixed error return on ida_simple_get() failure for fpga_mgr_register(),
> >>>>>>>>>         fpga_bridge_register(), and fpga_region_register().
> >>>>>>>>>       - Fixed error return value for fpga_bridge_register(): ERR_PTR(ret) instead
> >>>>>>>>>         of NULL.
> >>>>>>>>>
> >>>>>>>>> Changelog v1 -> v2:
> >>>>>>>>>       - Restored devm_fpga_mgr_register() functionality to the fpga-mgr
> >>>>>>>>>         class driver, adapted for the combined create/register functionality.
> >>>>>>>>>       - All previous callers of devm_fpga_mgr_register() will continue to call
> >>>>>>>>>         devm_fpga_mgr_register().
> >>>>>>>>>       - replaced unnecessary ternary operators in return statements with
> >>>>>>>>>         standard if conditions.
> >>>>>>>>>
> >>>>>>>>> Russ Weight (3):
> >>>>>>>>>       fpga: mgr: Use standard dev_release for class driver
> >>>>>>>>>       fpga: bridge: Use standard dev_release for class driver
> >>>>>>>>>       fpga: region: Use standard dev_release for class driver
> >>>>>>>>>
> >>>>>>>>>      Documentation/driver-api/fpga/fpga-bridge.rst |   6 +-
> >>>>>>>>>      Documentation/driver-api/fpga/fpga-mgr.rst    |  38 +++-
> >>>>>>>>>      Documentation/driver-api/fpga/fpga-region.rst |  12 +-
> >>>>>>>>>      drivers/fpga/altera-cvp.c                     |  12 +-
> >>>>>>>>>      drivers/fpga/altera-fpga2sdram.c              |  12 +-
> >>>>>>>>>      drivers/fpga/altera-freeze-bridge.c           |  10 +-
> >>>>>>>>>      drivers/fpga/altera-hps2fpga.c                |  12 +-
> >>>>>>>>>      drivers/fpga/altera-pr-ip-core.c              |   7 +-
> >>>>>>>>>      drivers/fpga/altera-ps-spi.c                  |   9 +-
> >>>>>>>>>      drivers/fpga/dfl-fme-br.c                     |  10 +-
> >>>>>>>>>      drivers/fpga/dfl-fme-mgr.c                    |  22 +-
> >>>>>>>>>      drivers/fpga/dfl-fme-region.c                 |  17 +-
> >>>>>>>>>      drivers/fpga/dfl.c                            |  12 +-
> >>>>>>>>>      drivers/fpga/fpga-bridge.c                    | 122 +++-------
> >>>>>>>>>      drivers/fpga/fpga-mgr.c                       | 215 ++++++++----------
> >>>>>>>>>      drivers/fpga/fpga-region.c                    | 119 ++++------
> >>>>>>>>>      drivers/fpga/ice40-spi.c                      |   9 +-
> >>>>>>>>>      drivers/fpga/machxo2-spi.c                    |   9 +-
> >>>>>>>>>      drivers/fpga/of-fpga-region.c                 |  10 +-
> >>>>>>>>>      drivers/fpga/socfpga-a10.c                    |  16 +-
> >>>>>>>>>      drivers/fpga/socfpga.c                        |   9 +-
> >>>>>>>>>      drivers/fpga/stratix10-soc.c                  |  16 +-
> >>>>>>>>>      drivers/fpga/ts73xx-fpga.c                    |   9 +-
> >>>>>>>>>      drivers/fpga/xilinx-pr-decoupler.c            |  17 +-
> >>>>>>>>>      drivers/fpga/xilinx-spi.c                     |  11 +-
> >>>>>>>>>      drivers/fpga/zynq-fpga.c                      |  16 +-
> >>>>>>>>>      drivers/fpga/zynqmp-fpga.c                    |   9 +-
> >>>>>>>>>      include/linux/fpga/fpga-bridge.h              |  30 ++-
> >>>>>>>>>      include/linux/fpga/fpga-mgr.h                 |  62 +++--
> >>>>>>>>>      include/linux/fpga/fpga-region.h              |  36 ++-
> >>>>>>>>>      30 files changed, 383 insertions(+), 511 deletions(-)
> >>>>>>>>>
> >
