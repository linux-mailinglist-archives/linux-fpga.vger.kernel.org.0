Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60B151DD8F
	for <lists+linux-fpga@lfdr.de>; Fri,  6 May 2022 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348099AbiEFQ0y (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 6 May 2022 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443733AbiEFQ0w (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 6 May 2022 12:26:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF2A6EB13;
        Fri,  6 May 2022 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651854174; x=1683390174;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XqmorIv1cLgso2fok5qBHAiakVVMo2/9VPLX4xMg6pk=;
  b=KuUDJpnWzwn89NTsrXcmSuzp/wlzFJkZp3hqmTFsKz5XirxA9obv6Noa
   sP5Gh6iAofbjbBG5VN8ylJOT5TOQZf8c+gEPNqocbOonS57a4Riz3wJkV
   nFJa688XyJ7XboJi5ruQ9reaPMZJzX2HKKWWN0TKx+4405qaRGCDqHfkM
   mSALLj2le7RhSLhqdCXx6YJ3vCI8jvzMhDek+G4EaFlI7o8OceRKKuAO5
   4EJQdxmQBTxQnwTiiEYgTvCi4oOPBl5m6TDhxJ4fjSergu6YnQ8u2lxub
   oJSKTdLCFyaQYLiFBjof3kI3m/cWANqzFDmQ2BuLbeSKdVOEQ3fWOmxvm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="268116885"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268116885"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 09:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="735802900"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2022 09:13:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn0aJ-000Ddb-TK;
        Fri, 06 May 2022 16:13:39 +0000
Date:   Sat, 7 May 2022 00:12:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     kbuild-all@lists.01.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, conor.dooley@microchip.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, system@metrotek.ru,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: Re: [PATCH v10 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <202205070006.tWQ4lFSL-lkp@intel.com>
References: <20220506125710.25550-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506125710.25550-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Ivan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220506]
[cannot apply to robh/for-next linus/master v5.18-rc5 v5.18-rc4 v5.18-rc3 v5.18-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Bornyakov/Microchip-Polarfire-FPGA-manager/20220506-212355
base:    38a288f5941ef03752887ad86f2d85442358c99a
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220507/202205070006.tWQ4lFSL-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9c87e90e1315e8a6028064516aef34a05f3f9625
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ivan-Bornyakov/Microchip-Polarfire-FPGA-manager/20220506-212355
        git checkout 9c87e90e1315e8a6028064516aef34a05f3f9625
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/fpga/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/fpga/microchip-spi.c: In function 'mpf_ops_parse_header':
>> drivers/fpga/microchip-spi.c:118:31: error: implicit declaration of function 'get_unaligned_le32' [-Werror=implicit-function-declaration]
     118 |                 block_start = get_unaligned_le32(buf + block_start_offset);
         |                               ^~~~~~~~~~~~~~~~~~
>> drivers/fpga/microchip-spi.c:152:26: error: implicit declaration of function 'get_unaligned_le16' [-Werror=implicit-function-declaration]
     152 |         components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
         |                          ^~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/get_unaligned_le32 +118 drivers/fpga/microchip-spi.c

    79	
    80	static int mpf_ops_parse_header(struct fpga_manager *mgr,
    81					struct fpga_image_info *info,
    82					const char *buf, size_t count)
    83	{
    84		size_t component_size_byte_num, component_size_byte_off,
    85		       components_size_start = 0, bitstream_start = 0,
    86		       block_id_offset, block_start_offset, i;
    87		u8 header_size, blocks_num, block_id;
    88		u32 block_start, component_size;
    89		u16 components_num;
    90	
    91		if (!buf) {
    92			dev_err(&mgr->dev, "Image buffer is not provided\n");
    93			return -EINVAL;
    94		}
    95	
    96		header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
    97		if (header_size > count) {
    98			info->header_size = header_size;
    99			return -EAGAIN;
   100		}
   101	
   102		/*
   103		 * Go through look-up table to find out where actual bitstream starts
   104		 * and where sizes of components of the bitstream lies.
   105		 */
   106		blocks_num = *(buf + header_size - 1);
   107		block_id_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET;
   108		block_start_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_START_OFFSET;
   109	
   110		header_size += blocks_num * MPF_LOOKUP_TABLE_RECORD_SIZE;
   111		if (header_size > count) {
   112			info->header_size = header_size;
   113			return -EAGAIN;
   114		}
   115	
   116		while (blocks_num--) {
   117			block_id = *(buf + block_id_offset);
 > 118			block_start = get_unaligned_le32(buf + block_start_offset);
   119	
   120			switch (block_id) {
   121			case MPF_BITSTREAM_ID:
   122				info->header_size = bitstream_start = block_start;
   123				if (block_start > count)
   124					return -EAGAIN;
   125	
   126				break;
   127			case MPF_COMPONENTS_SIZE_ID:
   128				components_size_start = block_start;
   129				break;
   130			default:
   131				break;
   132			}
   133	
   134			if (bitstream_start && components_size_start)
   135				break;
   136	
   137			block_id_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
   138			block_start_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
   139		}
   140	
   141		if (!bitstream_start || !components_size_start) {
   142			dev_err(&mgr->dev, "Failed to parse header look-up table\n");
   143			return -EFAULT;
   144		}
   145	
   146		/*
   147		 * Parse bitstream size.
   148		 * Sizes of components of the bitstream are 22-bits long placed next
   149		 * to each other. Image header should be extended by now up to where
   150		 * actual bitstream starts, so no need for overflow check anymore.
   151		 */
 > 152		components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
   153	
   154		for (i = 0; i < components_num; i++) {
   155			component_size_byte_num =
   156				(i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
   157			component_size_byte_off =
   158				(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
   159	
   160			component_size = get_unaligned_le32(buf +
   161							    components_size_start +
   162							    component_size_byte_num);
   163			component_size >>= component_size_byte_off;
   164			component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
   165	
   166			info->data_size += component_size * MPF_SPI_FRAME_SIZE;
   167		}
   168	
   169		return 0;
   170	}
   171	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
