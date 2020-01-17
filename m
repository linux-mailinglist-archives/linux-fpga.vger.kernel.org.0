Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDA81402AC
	for <lists+linux-fpga@lfdr.de>; Fri, 17 Jan 2020 04:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgAQD7x (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 16 Jan 2020 22:59:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:38286 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgAQD7x (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 16 Jan 2020 22:59:53 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 19:59:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,328,1574150400"; 
   d="scan'208";a="257652981"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jan 2020 19:59:52 -0800
Date:   Fri, 17 Jan 2020 11:39:34 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     will@kernel.org
Cc:     mdf@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [RESEND Patch v6 0/2] add performance reporting support to FPGA
 DFL drivers
Message-ID: <20200117033934.GA23536@hao-dev>
References: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579230628-22243-1-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Will

I resend this patch per suggestion from Greg.

Actually this is one important feature for users, but was blocked by
code review for quite a long time (no comments since last November).

We really need your help on code review from perf, please help us..

Many Thanks!

Hao

On Fri, Jan 17, 2020 at 11:10:26AM +0800, Wu Hao wrote:
> Hi all,
> 
> This patchset adds performance reporting support for FPGA DFL drivers. It
> introduces one pmu to expose userspace interfaces via standard perf API.
> User could use standard perf tool to access perf events exposed via pmu.
> 
> This patchset is generated based on latest fpga/for-next branch.
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
>  Documentation/fpga/dfl.rst  |  83 ++++
>  drivers/fpga/Makefile       |   1 +
>  drivers/fpga/dfl-fme-main.c |   4 +
>  drivers/fpga/dfl-fme-perf.c | 943 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/fpga/dfl-fme.h      |   2 +
>  drivers/fpga/dfl.h          |   2 +
>  6 files changed, 1035 insertions(+)
>  create mode 100644 drivers/fpga/dfl-fme-perf.c
> 
> -- 
> 1.8.3.1
