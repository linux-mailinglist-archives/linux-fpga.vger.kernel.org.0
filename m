Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4E27F6FD
	for <lists+linux-fpga@lfdr.de>; Thu,  1 Oct 2020 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbgJABHL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 30 Sep 2020 21:07:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:8006 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbgJABHL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 30 Sep 2020 21:07:11 -0400
IronPort-SDR: S3enRydT4cAp46T/xDqgRVNmaVPNhb4iMvHsJWc+8pgz/ZmkPqkwi14wQQHBnlo0n/Fwf6bd9h
 ME93+ek3t8yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="141993972"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="141993972"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 18:07:05 -0700
IronPort-SDR: aL1xFYH5NfFrPvYJiqGYGWqs04oPhr0Y4J5ZkkCYBrIakBkHzCRY/59YQRmWhFsufyDWNtvSH0
 X1IVLU0JZH+A==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457882317"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.15]) ([10.212.91.128])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 18:07:03 -0700
Subject: Re: [PATCH v1 01/12] fpga: fpga security manager class driver
To:     Moritz Fischer <mdf@kernel.org>
Cc:     lee.jones@linaro.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-2-russell.h.weight@intel.com>
 <20200916201604.GA1076460@epycbox.lan>
 <aab49157-5b2f-62b0-1682-635b6efbd546@intel.com>
 <20201001003101.GC121420@archbook>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <baf8eec6-c89e-43fc-ab79-9bbc46acd208@intel.com>
Date:   Wed, 30 Sep 2020 18:07:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201001003101.GC121420@archbook>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


Hi Moritz,

On 9/30/20 5:31 PM, Moritz Fischer wrote:
> I think providing the devm_ managed APIs is nicer, and makes it easier
> for the consumer of the API to do the right thing.

I see that the fpga_mgr code has support for two versions of the create()
and register() functions, one uses the devm_ approach, and the other does
not. Would also want to have two versions for the security manager?

- Russ
