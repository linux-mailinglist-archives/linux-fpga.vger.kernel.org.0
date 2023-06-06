Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6AD7235AB
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjFFDQr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 5 Jun 2023 23:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjFFDQq (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 5 Jun 2023 23:16:46 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35142118;
        Mon,  5 Jun 2023 20:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686021405; x=1717557405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oUlLrc5Ni/1xulzZF/t/S0SsmZ8L576B70G4zSv0/sA=;
  b=Ypuutuj+CKTAXwZIdW605h+VrARgyaEpQCOKG+F6ma0tLWrm2+4eTmWS
   ArdaCTgmqEPbYPoKHZZEjsBNWGFdU/5SCBFnXwCJRSRQSrWRID+yCR6KM
   lfS6MkjrYB1hlbboT/VRZgX4RnoZ0daVFwjwQSFgYUfRLrWj4ngk+X+cw
   F7ABw7IpRjddcdUooDFncpIoTnRXmiHQMroO0VpepEJF7bB8AGVrBhORZ
   xac9GrKfXR7nUm6pOsJJxzN7LATrMvaI0/ai7B73QZxaHLU4mIqX+XuLH
   udokj4HppIWG7AD2sEFOv3X/tNzxM2T8wiAd6h207ebJzVTbvD8AgkNwH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422377264"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422377264"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 20:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="778808700"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="778808700"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jun 2023 20:16:42 -0700
Date:   Tue, 6 Jun 2023 19:16:08 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        michal.simek@amd.com, linux-fpga@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
Subject: Re: [PATCH v3] fpga: zynq-fpga: Ensure proper xCAP interface switch
Message-ID: <ZH8VeI6094Ux39Fa@yilunxu-OptiPlex-7050>
References: <20230605115433.186087-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605115433.186087-1-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-05 at 17:24:33 +0530, Nava kishore Manne wrote:
> From: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> 
> The Zynq platform has PCAP, ICAP and JTAG interfaces for configuring
> programmable logic (PL). The existing driver implementation uses the
> PCAP interface to configure the PL. Before switching the PL configuration
> interface from PCAP to ICAP make sure that all outstanding Transactions
> relevant to the PL configuration should be completed by the PCAP interface
> otherwise it may lead to PL configuration issues.
> 
> This patch provides a required fix to ensure that all existing PL
> transactions are completed before switching from PCAP to ICAP.
> 
> For detailed information relevant to PL configuration interfaces refer
> Zynq 7000 TRM (section 6.5.1).
> Link: https://docs.xilinx.com/v/u/en-US/ug585-Zynq-7000-TRM
> 
> Signed-off-by: Alfonso Rodriguez <alfonso.rodriguezm@upm.es>
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

Applied.
