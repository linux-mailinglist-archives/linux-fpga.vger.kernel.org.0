Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9D108A07
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Nov 2019 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfKYI2P (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Nov 2019 03:28:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:60077 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfKYI2P (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Nov 2019 03:28:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 00:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,241,1571727600"; 
   d="scan'208";a="216880267"
Received: from hao-dev.bj.intel.com (HELO localhost) ([10.238.157.65])
  by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2019 00:28:12 -0800
Date:   Mon, 25 Nov 2019 16:08:39 +0800
From:   Wu Hao <hao.wu@intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     mdf@kernel.org, mark.rutland@arm.com, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        atull@kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v6 0/2] add performance reporting support to FPGA DFL
 drivers
Message-ID: <20191125080839.GA6227@hao-dev>
References: <1573622695-25607-1-git-send-email-hao.wu@intel.com>
 <20191125033412.GB890@hao-dev>
 <20191125080127.GC1809@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191125080127.GC1809@willie-the-truck>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Nov 25, 2019 at 08:01:28AM +0000, Will Deacon wrote:
> On Mon, Nov 25, 2019 at 11:34:12AM +0800, Wu Hao wrote:
> > Hi Will and Mark,
> > 
> > Could you please help us on review this patchset? as this patchset mainly 
> > introduced a new perf driver following the similar way as drivers/perf/*.
> 
> Why is it not under drivers/perf/, then?

Hi Will

Thanks for the quick response. This is one sub feature for DFL based FPGAs,
and we plan to put this sub feature together with others, including related
documentation. It only registers a standard perf pmu for its userspace
interfaces.

> 
> > This patchset has been submitted for a long time but didn't receive any
> > comment after v4. we appreciate any review comments! thanks in advance. :)
> 
> Hmm, not sure I saw the previous versions. Guessing I wasn't on cc?

We switched to perf API from v4, and started ccing you and Mark from v5. :)

Thanks
Hao

> 
> Will
