Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313A35A991
	for <lists+linux-fpga@lfdr.de>; Sat, 10 Apr 2021 02:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhDJAih (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 9 Apr 2021 20:38:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:56264 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235249AbhDJAig (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 9 Apr 2021 20:38:36 -0400
IronPort-SDR: pKGu0++YVfQK032fOr0K/4gvWJhBxnyhilF0Op+ySsfXmaa9Mfq7DhANFGrhRW6p1AV+gas12v
 rg3xskwZ65ww==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="193904199"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="193904199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 17:38:18 -0700
IronPort-SDR: 8HqSZh0EhJ8hL+DGeEifhbGAHLWFErtTge3hcRZaPAfj7f1Z3WLA3SwVDQNqI4HnfzVVW81K4Q
 84VzmfE5wvsA==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="416483083"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO rhweight-mobl2.ra.intel.com) ([10.255.231.225])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 17:38:18 -0700
From:   Russ Weight <russell.h.weight@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org
Cc:     trix@redhat.com, lgoncalv@redhat.com, yilun.xu@intel.com,
        hao.wu@intel.com, matthew.gerlach@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: [RFC PATCH v1 0/1] Extend FPGA manager with async image updates
Date:   Fri,  9 Apr 2021 17:38:09 -0700
Message-Id: <20210410003810.222597-1-russell.h.weight@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,

This RFC patch is a follow-on to my evaluation of the possibility of merging
secure update functionality into the FPGA Manager. My earlier RFC email
is here: https://marc.info/?l=linux-fpga&m=161783978715092&w=2.

This RFC patch implements the core fpga_sec_mgr_update() function from the
security manager patchset:
https://marc.info/?l=linux-fpga&m=161525020621455&w=2.

Specifically, it is a port of this patch:
https://marc.info/?l=linux-fpga&m=161525020721457&w=2

I think this patch provides enough context for further discussion. It
extends functionality without leveraging any common code (because I
didn't see an opportunity to share code).

In this patch, I am using the term "async" (in reference to the kernel
worker thread) instead of the term "security". While the security manager
patches were originally created specifically to support Intel secure image
updates, there is nothing inherently secure about the driver support, other
than the fact that the operation is essentially atomic: one write to the
"filename" sysfs entry is all that is required from user-space to do
an update. Our convention is to use signed, self-describing images that are
interpreted by the card BMC, but one could use a non-signed image or even
interpret the contents of the image based on the context of the parent
driver. I think the main differentiating factors are:

(1) sysfs interface: an update is an atomic operation accomplished with a
    single write.
(2) self-describing: The type of information contained in the FPGA Manager
    fpga_image_info structure would have to be included in the image file
    and interpreted by the parent driver (not the class driver).
(3) asynchronous: A write to the "filename" sysfs node write will return
    immediately and the update will proceed in the context of a kernel
    worker thread. Additional sysfs interfaces would be used to monitor the
    progress and determine the ultimate success or failure of the update.
(4) No notion of regions, bridges, or FPGA state. For Intel PAC cards, some
    image files don't even contain an FPGA image. If they do, the image could
    become active on the next power-cycle, or it could be activated through
    some other trigger mechanism.

Can existing ops be leveraged?
==============================
write: The current write op _could_ be used if the prototype were modified to
accept an additional offset parameter. For the async update, writes are done
in chunks, and the target offset needs to be passed on each write.

write_init and write_complete _could_ be used without change.

Other ops would have to be added: cancel, cleanup, hw_errinfo

I chose to implement all new ops because of the return data types. The fpga-mgr
ops use the standard negative errno values. More descriptive and relevant error
information can be provided via sysfs by defining a set of enum error codes.
For example, it is very helpful to be able to tell the user that they are in a
FLASH-wearout state, but standard errno values do not facilitate the
communication of a wearout error.

Would it be better to share the two or three ops that can be shared, and be
content with the standard error numbers? Or is it OK to use separate ops?

Should async updates be available via exported symbol?
======================================================
As I understand it, current image updates through the FPGA Manager are all
started with a call to the exported symbol fpga_mgr_load(). It would be
possible to export an fpga_mgr_async_load() symbol, but there would need
to be additional exported symbols to facilitate the collection of status
information. Is there a use case for this?

Can a common update function be used?
=====================================
fpga_mgr_async_update() is analagous to fpga_mgr_load(). However, all async
updates use the request_firmware framework. The FPGA Manager supports two
separate flows: a single image buffer or scatter-gather. It would be possible
to integrate these features for async updates, but I'm not sure that there is a
need for such functionality.

I look forward to your feedback. Do you see value in integrating the two
drivers? Should I continue this process?

- Russ

Russ Weight (1):
  fpga: mgr: enable asynchronous image updates

 .../ABI/testing/sysfs-class-fpga-manager      |   9 +
 drivers/fpga/fpga-mgr.c                       | 199 +++++++++++++++++-
 include/linux/fpga/fpga-mgr.h                 |  52 +++++
 3 files changed, 259 insertions(+), 1 deletion(-)

-- 
2.25.1

