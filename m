Return-Path: <linux-fpga+bounces-759-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F72995EFA
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 07:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C550F1F216CB
	for <lists+linux-fpga@lfdr.de>; Wed,  9 Oct 2024 05:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA85615CD49;
	Wed,  9 Oct 2024 05:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIlUGqCy"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E7149C50;
	Wed,  9 Oct 2024 05:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728451833; cv=none; b=aLafuEEii6cPByQ7Y8DEpz06puO8ZmztDMps9bPQMbmJm3KJtgikFZrTAUjk4i/j5G1LUrNh9/TzX8/M7oZPtE/H7SxLBkMuiCXb9rq1oKPjjhH5S7TSWOmr0GEWFE5XNujD69OfjemYXcXtUGGkKkUt+gU2cF9A6vmcgdl1LT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728451833; c=relaxed/simple;
	bh=VSUYUmtY8quANbEQtNDYVtgnqU7DGn2JR+gtgjQdhfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlA74TxRteWlnFDX0ogTbayiLWYOMGqp9fEtw0jQqfZs8rGlK6Ar3ZrsyzDP/lXNEFkNjd+YIBhIFL3Ju3nvRtDw2lhqlDIA+yEEfMuAD90r4Sdzxv1PgZvAXw3plwXzEe0z/3fJgXzcI9E8u29Qf34qXUKiMwOLVJaZf2mM9cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIlUGqCy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728451832; x=1759987832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VSUYUmtY8quANbEQtNDYVtgnqU7DGn2JR+gtgjQdhfI=;
  b=FIlUGqCyd0VEay7VtYh2FdAQDqUm50w++TexV5C/s0Z+GOxJ065Ww52x
   1f1j74e5w3eOM7urb6PuCswmaoRU4pfH+LA4SKcXoupv+JUi3PHlEcGuB
   DgbfeNCqsh4IiKGasSPXKXnBOSAmvmatHWCZjaFHorMtR90cjW8/afPKV
   ZLBKhJ1I5iJ9IeFIs7NhiNE90U2n21r8Tctryh6+1ixqXKdRbwJ9CAXQ8
   uITn9DChOTIm9m4kxiFrMWaDVBA7IM7n1k/sYymjelXDr2zNEA62GxujS
   H4ULk94oDQmpuccyUpT0HLn8e6sFlvqjjyZ8YiyNEgXKD8Y/WtgVjZFmk
   g==;
X-CSE-ConnectionGUID: iX47WNbKSqO9DWqLJzxppw==
X-CSE-MsgGUID: f2oDss9QTM6VY3e9zhcXYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38315937"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38315937"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 22:30:32 -0700
X-CSE-ConnectionGUID: G0K6UK4bRL2KJG2uRRWW1Q==
X-CSE-MsgGUID: 9nJqYqatTDq4Ckt1kyH8rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="106891950"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 22:30:29 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syPHH-0008my-0a;
	Wed, 09 Oct 2024 05:30:27 +0000
Date: Wed, 9 Oct 2024 13:29:50 +0800
From: kernel test robot <lkp@intel.com>
To: David Zhang <yidong.zhang@amd.com>, linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com,
	yilun.xu@intel.com
Cc: oe-kbuild-all@lists.linux.dev, Yidong Zhang <yidong.zhang@amd.com>,
	lizhi.hou@amd.com, Nishad Saraf <nishads@amd.com>,
	Prapul Krishnamurthy <prapulk@amd.com>
Subject: Re: [PATCH V1 2/3] drivers/fpga/amd: Add communication with firmware
Message-ID: <202410091338.c38eM1Hd-lkp@intel.com>
References: <20241007220128.3023169-2-yidong.zhang@amd.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007220128.3023169-2-yidong.zhang@amd.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Zhang/drivers-fpga-amd-Add-communication-with-firmware/20241008-060253
base:   linus/master
patch link:    https://lore.kernel.org/r/20241007220128.3023169-2-yidong.zhang%40amd.com
patch subject: [PATCH V1 2/3] drivers/fpga/amd: Add communication with firmware
config: i386-randconfig-054-20241009 (https://download.01.org/0day-ci/archive/20241009/202410091338.c38eM1Hd-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410091338.c38eM1Hd-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/fpga/amd/vmgmt-rm.c:183:2-3: Unneeded semicolon
--
>> drivers/fpga/amd/vmgmt-rm.c:498:10-17: WARNING: vzalloc should be used for buffer, instead of vmalloc/memset

vim +183 drivers/fpga/amd/vmgmt-rm.c

   146	
   147	int rm_queue_create_cmd(struct rm_device *rdev, enum rm_queue_opcode opcode,
   148				struct rm_cmd **cmd_ptr)
   149	{
   150		struct rm_cmd *cmd = NULL;
   151		int ret, id;
   152		u16 size;
   153	
   154		if (rdev->firewall_tripped)
   155			return -ENODEV;
   156	
   157		cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
   158		if (!cmd)
   159			return -ENOMEM;
   160		cmd->rdev = rdev;
   161	
   162		switch (opcode) {
   163		case RM_QUEUE_OP_LOAD_XCLBIN:
   164			fallthrough;
   165		case RM_QUEUE_OP_LOAD_FW:
   166			fallthrough;
   167		case RM_QUEUE_OP_LOAD_APU_FW:
   168			size = sizeof(struct rm_cmd_sq_bin);
   169			break;
   170		case RM_QUEUE_OP_GET_LOG_PAGE:
   171			size = sizeof(struct rm_cmd_sq_log_page);
   172			break;
   173		case RM_QUEUE_OP_IDENTIFY:
   174			size = 0;
   175			break;
   176		case RM_QUEUE_OP_VMR_CONTROL:
   177			size = sizeof(struct rm_cmd_sq_ctrl);
   178			break;
   179		default:
   180			vmgmt_err(rdev->vdev, "Invalid cmd opcode %d", opcode);
   181			ret = -EINVAL;
   182			goto error;
 > 183		};
   184	
   185		cmd->opcode = opcode;
   186		cmd->sq_msg.hdr.opcode = FIELD_PREP(RM_CMD_SQ_HDR_OPS_MSK, opcode);
   187		cmd->sq_msg.hdr.msg_size = FIELD_PREP(RM_CMD_SQ_HDR_SIZE_MSK, size);
   188	
   189		id = ida_alloc_range(&rm_cmd_ids, RM_CMD_ID_MIN, RM_CMD_ID_MAX, GFP_KERNEL);
   190		if (id < 0) {
   191			vmgmt_err(rdev->vdev, "Failed to alloc cmd ID: %d", id);
   192			ret = id;
   193			goto error;
   194		}
   195		cmd->sq_msg.hdr.id = id;
   196	
   197		init_completion(&cmd->executed);
   198	
   199		*cmd_ptr = cmd;
   200		return 0;
   201	error:
   202		kfree(cmd);
   203		return ret;
   204	}
   205	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

