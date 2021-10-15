Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3C042E6E6
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Oct 2021 04:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhJODAQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 14 Oct 2021 23:00:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:51980 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232233AbhJODAP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 14 Oct 2021 23:00:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10137"; a="228120361"
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="228120361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2021 19:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,374,1624345200"; 
   d="scan'208";a="492292183"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.162])
  by orsmga008.jf.intel.com with ESMTP; 14 Oct 2021 19:58:07 -0700
Date:   Fri, 15 Oct 2021 10:51:40 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Tom Rix <trix@redhat.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v17 0/5] FPGA Image Load (previously Security Manager)
Message-ID: <20211015025140.GH95330@yilunxu-OptiPlex-7050>
References: <450ed897-f726-9671-26b7-2a24bb046e89@redhat.com>
 <20211011014154.GA82360@yilunxu-OptiPlex-7050>
 <79350773-3629-2734-21c0-0314a762e722@redhat.com>
 <336e4827-b09a-e1ab-b67d-d8755012d71c@intel.com>
 <20211012074752.GB95330@yilunxu-OptiPlex-7050>
 <e629eca0-a86c-4028-7bbf-65185699137b@intel.com>
 <20211013010617.GE95330@yilunxu-OptiPlex-7050>
 <58036b2d-ca8f-2deb-f1b4-0301d633714b@intel.com>
 <20211014014947.GF95330@yilunxu-OptiPlex-7050>
 <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d1971d0-b50b-077f-2a82-83d822cd2ad7@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Oct 14, 2021 at 09:32:53AM -0700, Russ Weight wrote:
> 
> 
> On 10/13/21 6:49 PM, Xu Yilun wrote:
> > On Wed, Oct 13, 2021 at 11:09:08AM -0700, Russ Weight wrote:
> >>
> >> On 10/12/21 6:06 PM, Xu Yilun wrote:
> >>> On Tue, Oct 12, 2021 at 10:20:15AM -0700, Russ Weight wrote:
> >>>> On 10/12/21 12:47 AM, Xu Yilun wrote:
> >>>>> On Mon, Oct 11, 2021 at 06:00:16PM -0700, Russ Weight wrote:
> >>>>>> On 10/11/21 5:35 AM, Tom Rix wrote:
> >>>>>>> On 10/10/21 6:41 PM, Xu Yilun wrote:
> >>>>>>>> On Sat, Oct 09, 2021 at 05:11:20AM -0700, Tom Rix wrote:
> >>>>>>>>> On 10/9/21 1:08 AM, Xu Yilun wrote:
> >>>>>>>>>> On Wed, Sep 29, 2021 at 04:00:20PM -0700, Russ Weight wrote:
> >>>>>>>>>>> The FPGA Image Load framework provides an API to upload image
> >>>>>>>>>>> files to an FPGA device. Image files are self-describing. They could
> >>>>>>>>>>> contain FPGA images, BMC images, Root Entry Hashes, or other device
> >>>>>>>>>>> specific files. It is up to the lower-level device driver and the
> >>>>>>>>>>> target device to authenticate and disposition the file data.
> >>>>>>>>>> I've reconsider the FPGA persistent image update again, and think we
> >>>>>>>>>> may include it in FPGA manager framework.
> >>>>>>>>>>
> >>>>>>>>>> Sorry I raised this topic again when it is already at patch v17, but now
> >>>>>>>>>> I need to consider more seriously than before.
> >>>>>>>>>>
> >>>>>>>>>> We have consensus the FPGA persistent image update is just like a normal
> >>>>>>>>>> firmware update which finally writes the nvmem like flash or eeprom,
> >>>>>>>>>> while the current FPGA manager deals with the active FPGA region update
> >>>>>>>>>> and re-activation. Could we just expand the FPGA manager and let it handle
> >>>>>>>>>> the nvmem update as well? Many FPGA cards have nvmem and downloaders
> >>>>>>>>>> supports updating both FPGA region and nvmem.
> >>>>>> The fpga-image-load driver is actually just a data transfer. The class
> >>>>> IMHO, The fpga-mgr dev is also a data transfer. The fpga-region dev is
> >>>>> acting as the FPGA region admin responsible for gating, transfering and
> >>>>> re-enumerating.
> >>>>>
> >>>>> So my opinion is to add a new data transfer type and keep a unified process.
> >>>>>
> >>>>>> driver has no knowledge about what the data is or where/if the data will
> >>>>>> be stored.
> >>>>> The fpga-image-load driver knows the data will be stored in nvmem,
> >>>> FYI: This is not strictly correct. In a coming product there is a
> >>>> case where the data will be stored in RAM. Richard Gong was also
> >>>> looking to use this driver to validate an image without programming
> >>>> or storing it. The fpga-image-load driver has no expectation that
> >>>> the data will be stored in nvmem, or even that it will be stored
> >>>> at all.
> >>> OK, we can discuss that use case then. But fundamentally a driver should
> >>> be clear what it is doing.
> >> The lower-level driver is, of course, clear what it is doing. And the
> >> FPGA Image Load Framework simply provides a consistent API and manages
> >> a potentially long-running data transfer in the context of a kernel
> >> worker thread.
> >>
> >> It sounds like you are saying that that is not "clear enough" in the
> >> context of the FPGA Manager?
> >>
> >> The files that are used with Intel PAC devices are self-describing. The
> >> user-space tools, the class driver and the lower-level driver just pass
> >> the data through to the card BMC without any knowledge of the content,
> >> purpose or final destination of the data.
> >>
> >> The card BMC will receive signed data, validate it, and process it as a
> >> BMC image, an FPGA image, a Root Entry Hash, or a key cancellation. In
> > I category all these actions as firmware update fully or partially on
> > persistent storage. The FPGA Manager don't have to know the meaning of
> > every byte on flash, but it should be aware the firmware is updated and
> > the card may acts differently with a new firmware. This is the common
> > working model for most of the FPGA cards so that we implement it in FPGA
> > manager class. 
> >
> >> the n6000, it could also be part of a multi-step process for programming
> >> SDM keys and the data may not be stored permanently.
> > This is new to me, but seems to be different from firmware update, so lets
> > think about it again.
> >
> >>> You may try to extend the FPGA framework to
> >>> support nvmem storage, or image validation, but cannot say we feed the
> >>> data to any engine undefined by the framework.
> >> I'm not sure what you mean by "feed the data to any engine undefined by the
> >> framework". I think the "engine" is the lower level driver/device that invokes
> >> the fpga_mgr. The lower level driver, of course, is clear what it is doing.
> >> The fpga_mgr cannot control what driver invokes it.
> >>
> >> Are saying that when invoking the fpga-mgr, that it _must_ also pass descriptive
> >> data. Meaning that a self-describing file alone is not acceptable?
> > The class driver should define a reasonable working model and APIs.
> > Updating the FPGA backup storage is good to me. But receiving a mystery
> > box and do whatever it requires is not.
> >
> > Self-describing file is OK, encryption is OK, but either the class
> > driver itself, or with the help of the low level driver, should make
> > sure it works within its scope.
> In our secure update process, the card BMC firmware authenticates
> the data using the root entry hashes and will either reject the
> data or perform some function based on the contents. Neither the
> user-space, the class driver, nor the lower level driver know
> what the contents are. It _is_ a "mystery box" to them. How do we
> verify scope in this model?

I think we need to find out how. One case is, the HW is designed to have
one single function, such as firmware update, then any image input
through firmware update API is within expectation, and the driver
should only serve the firmware update API. I think this is how the
N3000 is working now. If the HW is for another function, register itself
to serve another API, or another class driver.

Another case is, the HW could do multiple types of tasks depending on
the content of the image, such as firmware update, image verification,
or assumably power off the card ... There should be some mechanism for
the driver to only accept the right image according to what API is called.
Or the user may input an image named update_the_card.img through
firmware update API and finally get the card off. Having some headers
readable by host for the operation type? Or, some HW interface for host
to apply the operation type as well as the image, let the HW verify?
Let's think about it.

> 
> As you have noted, most current cases result in a change to the
> card, and I suspect that it will remain that way. But that can't be
> guaranteed, and I'm not convinced that a host driver needs to be
> concerned about it.

A host driver should know what is done, in some abstraction level.
I think updating the persistent storage is an acceptable abstraction
in FPGA domain, so I'd like to extend it in FPGA manager. But doing
anything according to the image is not.

Thanks,
Yilun

> 
> - Russ
> 
> >
> > Thanks,
> > Yilun
> >
> >> Thanks,
> >> - Russ
> >>
> >>> Thanks,
> >>> Yilun
> >>>
> >>>>> while
> >>>>> the fpga-mgr knows the data will be stored in FPGA cells. They may need
> >>>>> to know the exact physical position to store, may not, depends on what the
> >>>>> HW engines are.
> >>>>>
> >>>>>> This functionality could, of course, be merged into the fpga-mgr. I did
> >>>>>> a proof of concept of this a while back and we discussed the pros and cons.
> >>>>>> See this email for a recap:
> >>>>>>
> >>>>>> https://marc.info/?l=linux-fpga&m=161998085507374&w=2
> >>>>>>
> >>>>>> Things have changed some with the evolution of the driver. The IOCTL
> >>>>>> approach probably fits better than the sysfs implementation. At the time
> >>>>>> it seemed that a merge would add unnecessary complexity without adding value.
> >>>>> I think at least developers don't have to go through 2 sets of software
> >>>>> stacks which are of the same concept. And adding some new features like
> >>>>> optionally threading or canceling data transfer are also good to FPGA
> >>>>> region update. And the nvmem update could also be benifit from exsiting
> >>>>> implementations like scatter-gather buffers, in-kernel firmware loading.
> >>>>>
> >>>>> I try to explain myself according to each of your concern from that mail
> >>>>> thread:
> >>>>>
> >>>>> Purpose of the 2 updates
> >>>>> ========================
> >>>>>
> >>>>>   As I said before, I think they are both data transfer devices. FPGA
> >>>>> region update gets extra support from fpga-region & fpga-bridge, and
> >>>>> FPGA nvmem update could be a standalone fpga-mgr.
> >>>>>
> >>>>> Extra APIs that are unique to nvmem update
> >>>>> ==========================================
> >>>>>
> >>>>>   cdev APIs for nvmem update:
> >>>>>     Yes we need to expand the functionality so we need them.
> >>>>>
> >>>>>   available_images, image_load APIs for loading nvmem content to FPGA
> >>>>>   region:
> >>>>>     These are features in later patchsets which are not submitted, but we
> >>>>>     could talk about it in advance. I think this is actually a FPGA region
> >>>>>     update from nvmem, it also requires gating, data loading (no SW transfer)
> >>>>>     and re-enumeration, or a single command to image_load HW may result system
> >>>>>     disordered. The FPGA framework now only supports update from in-kernel
> >>>>>     user data, maybe we add support for update from nvmem later.
> >>>>>
> >>>>>   fpga-mgr state extend:
> >>>>>     I think it could be extended, The current states are not perfect,
> >>>>>     adding something like IDLE or READY is just fine.
> >>>>>
> >>>>>   fpga-mgr status extend:
> >>>>>     Add general error definitions as needed. If there is some status
> >>>>>     that is quite vendor specific, expose it in low-level driver.
> >>>>>
> >>>>>   remaining-size:
> >>>>>     Nice to have for all.
> >>>>>
> >>>>> Threading the update
> >>>>> ====================
> >>>>>
> >>>>>   Also a good option for FPGA region update, maybe we also have a slow FPGA
> >>>>>   reprogrammer?
> >>>>>
> >>>>> Cancelling the update
> >>>>> ====================
> >>>>>
> >>>>>   Also a good option for FPGA region update if HW engine supports.
> >>>> These are all good points.
> >>>>
> >>>> Thanks,
> >>>> - Russ
> >>>>> Thanks,
> >>>>> Yilun
> >>>>>
> >>>>>>>>>> According to the patchset, the basic workflow of the 2 update types are
> >>>>>>>>>> quite similar, get the data, prepare for the HW, write and complete.
> >>>>>>>>>> They are already implemented in FPGA manager. We've discussed some
> >>>>>>>>>> differences like threading or canceling the update, which are
> >>>>>>>>>> not provided by FPGA manager but they may also nice to have for FPGA
> >>>>>>>>>> region update. An FPGA region update may also last for a long time??
> >>>>>>>>>> So I think having 2 sets of similar frameworks in FPGA is unnecessary.
> >>>>>>>>>>
> >>>>>>>>>> My quick mind is that we add some flags in struct fpga_mgr & struct
> >>>>>>>>>> fpga_image_info to indicate the HW capability (support FPGA region
> >>>>>>>>>> update or nvmem update or both) of the download engine and the provided
> >>>>>>>>>> image type. Then the low-level driver knows how to download if it
> >>>>>>>>>> supports both image types.An char device could be added for each fpga manager dev, providing the
> >>>>>>>>>> user APIs for nvmem update. We may not use the char dev for FPGA region
> >>>>>>>>>> update cause it changes the system HW devices and needs device hotplug
> >>>>>>>>>> in FPGA region. We'd better leave it to FPGA region class, this is
> >>>>>>>>>> another topic.
> >>>>>> I'll give this some more thought and see if I can come up with some RFC
> >>>>>> patches.
> >>>>>>
> >>>>>> - Russ
> >>>>>>>>>> More discussion is appreciated.
> >>>>>>>>> I also think fpga_mgr could be extended.
> >>>>>>>>>
> >>>>>>>>> In this patchset,
> >>>>>>>>>
> >>>>>>>>> https://lore.kernel.org/linux-fpga/20210625195849.837976-1-trix@redhat.com/
> >>>>>>>>>
> >>>>>>>>> A second, similar set of write ops was added to fpga_manger_ops,
> >>>>>>>>>
> >>>>>>>>> new bit/flag was added to fpga_image_info
> >>>>>>>>>
> >>>>>>>>> The intent was for dfl to add their specific ops to cover what is done in
> >>>>>>>>> this patchset.
> >>>>>>>> I think we don't have to add 2 ops for reconfig & reimage in framework,
> >>>>>>>> the 2 processes are almost the same.
> >>>>>>>>
> >>>>>>>> Just add the _REIMAGE (or something else, NVMEM?) flag for
> >>>>>>>> fpga_image_info, and low level drivers handle it as they do for other
> >>>>>>>> flags.
> >>>>>>>>
> >>>>>>>> How do you think?
> >>>>>>> A single set is fine.
> >>>>>>>
> >>>>>>> A difficult part of is the length of  time to do the write. The existing write should be improved to use a worker thread.
> >>>>>>>
> >>>>>>> Tom
> >>>>>>>
> >>>>>>>> Thanks,
> >>>>>>>> Yilun
> >>>>>>>>
> >>>>>>>>> Any other driver would do similar.
> >>>>>>>>>
> >>>>>>>>> Is this close to what you are thinking ?
> >>>>>>>>>
> >>>>>>>>> Tom
> >>>>>>>>>
> >>>>>>>>>> Thanks,
> >>>>>>>>>> Yilun
> >>>>>>>>>>
