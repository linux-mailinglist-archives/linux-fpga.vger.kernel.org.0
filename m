Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1817DA4A
	for <lists+linux-fpga@lfdr.de>; Mon,  9 Mar 2020 09:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIIJL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 9 Mar 2020 04:09:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:11140 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgCIIJL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 9 Mar 2020 04:09:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 01:09:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="353318738"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2020 01:09:08 -0700
Date:   Mon, 9 Mar 2020 15:47:58 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        gregkh@linuxfoundation.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org, yilun.xu@intel.com
Subject: Re: [PATCH v8 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20200309074758.GA4295@hao-dev>
References: <1582503707-10737-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582503707-10737-1-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Will,

Just a gentle ping. Do you have Any comments to this new version?

Hao

On Mon, Feb 24, 2020 at 08:21:45AM +0800, Wu Hao wrote:
> Hi all,
> 
> This patchset adds performance reporting support for FPGA DFL drivers. It
> introduces one pmu to expose userspace interfaces via standard perf API.
> User could use standard perf tool to access perf events exposed via pmu.
> 
> This patchset is generated based on 5.6-rc2.
> 
> Main changes from v7:
>  - rename pmu name from "fme%d" to "dfl_fme%d".
>  - monitor cpu hotplug for cpumask sysfs and update cpumask sysfs doc.
>  - add extra read for 64bit counter registers to avoid 2-32bit readl issue.
> 
> Main changes from v6:
>  - add a new ABI/testing/ sysfs documentation in patch #2.
>  - fix a warning reported by kbuild in patch #2.
> 
> Main changes from v5:
>  - use dev_ext_attribute instead of fme_perf_event_attr.
>  - use is_visible function to decide which events to expose per
>    hardware capability, and add event_init checking for all events.
> 
> Main changes from v4:
>  - rebase and clean up.
>  - update Kconfig for PERF_EVENTS dependency.
> 
> Main changes from v3:
>  - add more descriptions in doc, including how to use perf tool for these
>    hardware counters. (patch #1)
>  - use standard perf API instead of sysfs entries. (patch #2)
> 
> Wu Hao (1):
>   fpga: dfl: fme: add performance reporting support
> 
> Xu Yilun (1):
>   Documentation: fpga: dfl: add description for performance reporting
>     support
> 
>  .../testing/sysfs-bus-event_source-devices-dfl_fme |  104 ++
>  Documentation/fpga/dfl.rst                         |   84 ++
>  drivers/fpga/Kconfig                               |    2 +-
>  drivers/fpga/Makefile                              |    1 +
>  drivers/fpga/dfl-fme-main.c                        |    4 +
>  drivers/fpga/dfl-fme-perf.c                        | 1021 ++++++++++++++++++++
>  drivers/fpga/dfl-fme.h                             |    2 +
>  drivers/fpga/dfl.h                                 |    2 +
>  8 files changed, 1219 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices-dfl_fme
>  create mode 100644 drivers/fpga/dfl-fme-perf.c
> 
> -- 
> 1.8.3.1
