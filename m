Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684081086E2
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Nov 2019 04:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKYDxs (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 24 Nov 2019 22:53:48 -0500
Received: from mga07.intel.com ([134.134.136.100]:47711 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726921AbfKYDxs (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 24 Nov 2019 22:53:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Nov 2019 19:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,240,1571727600"; 
   d="scan'208";a="210898419"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2019 19:53:45 -0800
Date:   Mon, 25 Nov 2019 11:34:12 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, will@kernel.org, mark.rutland@arm.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, atull@kernel.org,
        gregkh@linuxfoundation.org, hao.wu@intel.com
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20191125033412.GB890@hao-dev>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Nov 13, 2019 at 01:24:53PM +0800, Wu Hao wrote:
> Hi Moritz and all,

Hi Will and Mark,

Could you please help us on review this patchset? as this patchset mainly 
introduced a new perf driver following the similar way as drivers/perf/*.

Hi Moritz,

Could you please help us on review the other parts?

This patchset has been submitted for a long time but didn't receive any
comment after v4. we appreciate any review comments! thanks in advance. :)


Hao

> 
> This patchset adds performance reporting support for FPGA DFL drivers. It
> introduces one pmu to expose userspace interfaces via standard perf API.
> User could use standard perf tool to access perf events exposed via pmu.
> 
> This patchset is generated based on fpga/for-next branch.
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
