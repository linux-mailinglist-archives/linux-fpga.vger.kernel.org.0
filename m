Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAF840A269
	for <lists+linux-fpga@lfdr.de>; Tue, 14 Sep 2021 03:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbhINBWy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 13 Sep 2021 21:22:54 -0400
Received: from mga07.intel.com ([134.134.136.100]:12251 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230131AbhINBWy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 13 Sep 2021 21:22:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="285532144"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="285532144"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 18:21:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="551982408"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by fmsmga002.fm.intel.com with ESMTP; 13 Sep 2021 18:21:32 -0700
Date:   Tue, 14 Sep 2021 09:14:58 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Tom Rix <trix@redhat.com>
Cc:     Russ Weight <russell.h.weight@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v14 1/4] fpga: m10bmc-sec: create max10 bmc secure update
  driver
Message-ID: <20210914011458.GA777028@yilunxu-OptiPlex-7050>
References: <20210909233304.5650-1-russell.h.weight@intel.com>
 <20210909233304.5650-2-russell.h.weight@intel.com>
 <20210910151335.GB757507@yilunxu-OptiPlex-7050>
 <1e4a9cc9-4390-1c9d-5ec0-7e9295158dfa@intel.com>
 <ce3039c5-d18a-87d5-229d-5ff571c2aaa9@redhat.com>
 <20210913053747.GE754505@yilunxu-OptiPlex-7050>
 <41b42ae2-6cbc-fec2-44b3-6353507e1b02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41b42ae2-6cbc-fec2-44b3-6353507e1b02@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Sep 13, 2021 at 05:12:32AM -0700, Tom Rix wrote:
> 
> On 9/12/21 10:37 PM, Xu Yilun wrote:
> > On Sat, Sep 11, 2021 at 12:04:07PM -0700, Tom Rix wrote:
> > > On 9/10/21 1:27 PM, Russ Weight wrote:
> > > > On 9/10/21 8:13 AM, Xu Yilun wrote:
> > > > > On Thu, Sep 09, 2021 at 04:33:01PM -0700, Russ Weight wrote:
> > > > > > Create a sub driver for the FPGA Card BMC in order to support secure
> > > > > > updates.  This sub-driver will invoke an instance of the FPGA Image Load
> > > > > > class driver for the image load portion of the update.
> > > > > > 
> > > > > > This patch creates the MAX10 BMC Secure Update driver and provides sysfs
> > > > > > files for displaying the current root entry hashes for the FPGA static
> > > > > > region, the FPGA PR region, and the MAX10 BMC.
> > > > > > 
> > > > > > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > > > > > Reviewed-by: Tom Rix <trix@redhat.com>
> > > > > > ---
> > > > > > v14:
> > > > > >     - Changed symbol and text references to reflect the renaming of the
> > > > > >       Security Manager Class driver to FPGA Image Load.
> > > > > > v13:
> > > > > >     - Updated copyright to 2021
> > > > > >     - Updated ABI documentation date and kernel version
> > > > > >     - Call updated fpga_sec_mgr_register() and fpga_sec_mgr_unregister()
> > > > > >       functions instead of devm_fpga_sec_mgr_create() and
> > > > > >       devm_fpga_sec_mgr_register().
> > > > > > v12:
> > > > > >     - Updated Date and KernelVersion fields in ABI documentation
> > > > > > v11:
> > > > > >     - Added Reviewed-by tag
> > > > > > v10:
> > > > > >     - Changed the path expressions in the sysfs documentation to
> > > > > >       replace the n3000 reference with something more generic to
> > > > > >       accomodate other devices that use the same driver.
> > > > > > v9:
> > > > > >     - Rebased to 5.12-rc2 next
> > > > > >     - Updated Date and KernelVersion in ABI documentation
> > > > > > v8:
> > > > > >     - Previously patch 2/6, otherwise no change
> > > > > > v7:
> > > > > >     - Updated Date and KernelVersion in ABI documentation
> > > > > > v6:
> > > > > >     - Added WARN_ON() call for (sha_num_bytes / stride) to assert
> > > > > >       that the proper count is passed to regmap_bulk_read().
> > > > > > v5:
> > > > > >     - No change
> > > > > > v4:
> > > > > >     - Moved sysfs files for displaying the root entry hashes (REH)
> > > > > >       from the FPGA Security Manager class driver to here. The
> > > > > >       m10bmc_reh() and m10bmc_reh_size() functions are removed and
> > > > > >       the functionality from these functions is moved into a
> > > > > >       show_root_entry_hash() function for displaying the REHs.
> > > > > >     - Added ABI documentation for the new sysfs entries:
> > > > > >       sysfs-driver-intel-m10-bmc-secure
> > > > > >     - Updated the MAINTAINERS file to add the new ABI documentation
> > > > > >       file: sysfs-driver-intel-m10-bmc-secure
> > > > > >     - Removed unnecessary ret variable from m10bmc_secure_probe()
> > > > > >     - Incorporated new devm_fpga_sec_mgr_register() function into
> > > > > >       m10bmc_secure_probe() and removed the m10bmc_secure_remove()
> > > > > >       function.
> > > > > > v3:
> > > > > >     - Changed from "Intel FPGA Security Manager" to FPGA Security Manager"
> > > > > >     - Changed: iops -> sops, imgr -> smgr, IFPGA_ -> FPGA_, ifpga_ to fpga_
> > > > > >     - Changed "MAX10 BMC Secure Engine driver" to "MAX10 BMC Secure
> > > > > >       Update driver"
> > > > > >     - Removed wrapper functions (m10bmc_raw_*, m10bmc_sys_*). The
> > > > > >       underlying functions are now called directly.
> > > > > >     - Changed "_root_entry_hash" to "_reh", with a comment explaining
> > > > > >       what reh is.
> > > > > > v2:
> > > > > >     - Added drivers/fpga/intel-m10-bmc-secure.c file to MAINTAINERS.
> > > > > >     - Switched to GENMASK(31, 16) for a couple of mask definitions.
> > > > > >     - Moved MAX10 BMC address and function definitions to a separate
> > > > > >       patch.
> > > > > >     - Replaced small function-creation macros with explicit function
> > > > > >       declarations.
> > > > > >     - Removed ifpga_sec_mgr_init() and ifpga_sec_mgr_uinit() functions.
> > > > > >     - Adapted to changes in the Intel FPGA Security Manager by splitting
> > > > > >       the single call to ifpga_sec_mgr_register() into two function
> > > > > >       calls: devm_ifpga_sec_mgr_create() and ifpga_sec_mgr_register().
> > > > > > ---
> > > > > >    .../testing/sysfs-driver-intel-m10-bmc-secure |  29 ++++
> > > > > >    MAINTAINERS                                   |   2 +
> > > > > >    drivers/fpga/Kconfig                          |  11 ++
> > > > > >    drivers/fpga/Makefile                         |   3 +
> > > > > >    drivers/fpga/intel-m10-bmc-secure.c           | 145 ++++++++++++++++++
> > > > > >    5 files changed, 190 insertions(+)
> > > > > >    create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> > > > > >    create mode 100644 drivers/fpga/intel-m10-bmc-secure.c
> > > > > > 
> > > > > > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> > > > > > new file mode 100644
> > > > > > index 000000000000..363403ce992d
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> > > > > > @@ -0,0 +1,29 @@
> > > > > > +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_root_entry_hash
> > > > > > +Date:		Aug 2021
> > > > > > +KernelVersion:	5.15
> > > > > > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > > > > > +Description:	Read only. Returns the root entry hash for the static
> > > > > > +		region if one is programmed, else it returns the
> > > > > > +		string: "hash not programmed".  This file is only
> > > > > > +		visible if the underlying device supports it.
> > > > > > +		Format: "0x%x".
> > > > > > +
> > > > > > +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_root_entry_hash
> > > > > > +Date:		Aug 2021
> > > > > > +KernelVersion:	5.15
> > > > > > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > > > > > +Description:	Read only. Returns the root entry hash for the partial
> > > > > > +		reconfiguration region if one is programmed, else it
> > > > > > +		returns the string: "hash not programmed".  This file
> > > > > > +		is only visible if the underlying device supports it.
> > > > > > +		Format: "0x%x".
> > > > > > +
> > > > > > +What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_root_entry_hash
> > > > > > +Date:		Aug 2021
> > > > > > +KernelVersion:	5.15
> > > > > > +Contact:	Russ Weight <russell.h.weight@intel.com>
> > > > > > +Description:	Read only. Returns the root entry hash for the BMC image
> > > > > > +		if one is programmed, else it returns the string:
> > > > > > +		"hash not programmed".  This file is only visible if the
> > > > > > +		underlying device supports it.
> > > > > > +		Format: "0x%x".
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index e3fbc1bde9bc..cf93835b4775 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -7363,8 +7363,10 @@ M:	Russ Weight <russell.h.weight@intel.com>
> > > > > >    L:	linux-fpga@vger.kernel.org
> > > > > >    S:	Maintained
> > > > > >    F:	Documentation/ABI/testing/sysfs-class-fpga-image-load
> > > > > > +F:	Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
> > > > > Should we change the name of the driver? Some keywords like "image load"
> > > > > or "firmware update" should be in the name.
> > > > I considered that. The image-upload functionality is a subset of  this
> > > > driver. It also exposes security collateral via sysfs, and the image-load
> > > > triggers and power-on-image sysfs files will probably end up in this
> > > > driver too.
> > > > 
> > > > The current driver name is intel-m10-bmc-secure. Do we need to keep
> > > > "intel-m10-bmc" in the name?
> > > > 
> > > > intel-m10-bmc-sec-fw-update?
> > > > intel-m10-bmc-sec-update?
> > > > 
> > > > What do you think? Any other suggestions?
> > The single word "secure" is quite indistinct to me. I think
> > intel-m10-bmc-sec-update is much better.
> 
> This fine.
> 
> Should it move to mfd/ ?

I think not. The mfd folder only contains MFD parent device drivers. The
subdev drivers are placed in various class folder according to their own
functionality.

Thanks,
Yilun

> 
> Tom
> 
> > 
> > > The prefix intel-m10-bmc-sec is clunky and confuses me because I think of
> > > mfd/intel-m10-bmc.c
> > The secure update engine is now implemented in MAX10 bmc. The driver
> > code also assumes it is always a sub device of MAX10 bmc. So my
> > preference is we keep the prefix.
> > 
> > > How about
> > > 
> > > dfl-image-load ?
> > There may be several secure update engines for DFL based FPGAs. So we
> > may be more specific.
> > 
> > Thanks,
> > Yilun
> > 
