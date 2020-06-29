Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E9420D902
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Jun 2020 22:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgF2TnS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Jun 2020 15:43:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:36333 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732672AbgF2TnR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Jun 2020 15:43:17 -0400
IronPort-SDR: Zab84ZyuxwMtLTU3zYs9gkHthZq/uMEO/XCVE50XK5JSJHcBVeNz2toZNpXo1a48trBidzduoy
 BGTQ8uV9AjFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="143524122"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="143524122"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 12:23:06 -0700
IronPort-SDR: /8ysNShuu6jeu9vrKr+838/Q2FcjB8x7FJyxHPPan7SVPUQrh5wOw+n2CLD1tL+DnE5Eb3ZCkl
 yfDAdbFm5cFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="gz'50?scan'50,208,50";a="355548506"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Jun 2020 12:23:04 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jpzMt-000198-Bj; Mon, 29 Jun 2020 19:23:03 +0000
Date:   Tue, 30 Jun 2020 03:22:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     trix@redhat.com, mdf@kernel.org
Cc:     kbuild-all@lists.01.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH] fpga: dfl: improve configuration of dfl pci devices
Message-ID: <202006300334.7lnHLOjX%lkp@intel.com>
References: <20200628151813.7679-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20200628151813.7679-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.8-rc3 next-20200629]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use  as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/trix-redhat-com/fpga-dfl-improve-configuration-of-dfl-pci-devices/20200628-231854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 719fdd32921fb7e3208db8832d32ae1c2d68900f
config: s390-randconfig-s031-20200629 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C= CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=s390 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/fpga/dfl-fme-perf.c:788:61: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:789:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
>> drivers/fpga/dfl-fme-perf.c:789:38: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:789:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:789:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:792:47: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:797:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:797:38: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:797:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:797:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:798:43: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:803:18: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:803:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:811:13: sparse: sparse: undefined identifier 'is_sampling_event'
   drivers/fpga/dfl-fme-perf.c:814:18: sparse: sparse: using member 'cpu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:817:18: sparse: sparse: using member 'cpu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:820:19: sparse: sparse: using member 'attr' in incomplete struct perf_event
>> drivers/fpga/dfl-fme-perf.c:820:19: sparse: sparse: incompatible types for operation (>):
>> drivers/fpga/dfl-fme-perf.c:820:19: sparse:    unsigned long long
>> drivers/fpga/dfl-fme-perf.c:820:19: sparse:    bad type
   drivers/fpga/dfl-fme-perf.c:820:19: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:820:19: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:821:18: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:821:18: sparse: sparse: incompatible types for operation (>):
   drivers/fpga/dfl-fme-perf.c:821:18: sparse:    unsigned long long
   drivers/fpga/dfl-fme-perf.c:821:18: sparse:    bad type
   drivers/fpga/dfl-fme-perf.c:821:18: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:821:18: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:822:18: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:822:18: sparse: sparse: incompatible types for operation (>):
   drivers/fpga/dfl-fme-perf.c:822:18: sparse:    unsigned long long
   drivers/fpga/dfl-fme-perf.c:822:18: sparse:    bad type
   drivers/fpga/dfl-fme-perf.c:822:18: sparse: sparse: using member 'attr' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:822:18: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:826:12: sparse: sparse: using member 'event_base' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:827:12: sparse: sparse: using member 'idx' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:828:12: sparse: sparse: using member 'config_base' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:830:14: sparse: sparse: using member 'destroy' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:844:61: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:845:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:845:38: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:845:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:845:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:846:43: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:849:47: sparse: sparse: using member 'idx' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:849:57: sparse: sparse: using member 'config_base' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:850:16: sparse: sparse: using member 'prev_count' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:853:9: sparse: sparse: using member 'count' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:858:61: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:859:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:859:38: sparse: sparse: cast from unknown type
   drivers/fpga/dfl-fme-perf.c:859:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:859:38: sparse: sparse: using member 'pmu' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:860:43: sparse: sparse: using member 'hw' in incomplete struct perf_event
   drivers/fpga/dfl-fme-perf.c:863:49: sparse: sparse: using member 'idx' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:863:59: sparse: sparse: using member 'config_base' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:864:9: sparse: sparse: using member 'prev_count' in incomplete struct hw_perf_event
   drivers/fpga/dfl-fme-perf.c:929:15: sparse: sparse: undefined identifier 'perf_pmu_register'
   drivers/fpga/dfl-fme-perf.c:938:9: sparse: sparse: undefined identifier 'perf_pmu_unregister'
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val
   include/asm-generic/io.h:236:22: sparse:     got restricted __le64 [usertype]
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:193:15: sparse: sparse: cast to restricted __le64
   include/asm-generic/io.h:236:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long long [usertype] val @@     got restricted __le64 [usertype] @@
   include/asm-generic/io.h:236:22: sparse:     expected unsigned long long [usertype] val

vim +789 drivers/fpga/dfl-fme-perf.c

724142f8c42a7b Wu Hao 2020-04-27  785  
724142f8c42a7b Wu Hao 2020-04-27  786  static void fme_perf_event_destroy(struct perf_event *event)
724142f8c42a7b Wu Hao 2020-04-27  787  {
724142f8c42a7b Wu Hao 2020-04-27  788  	struct fme_perf_event_ops *ops = get_event_ops(event->hw.event_base);
724142f8c42a7b Wu Hao 2020-04-27 @789  	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
724142f8c42a7b Wu Hao 2020-04-27  790  
724142f8c42a7b Wu Hao 2020-04-27  791  	if (ops->event_destroy)
724142f8c42a7b Wu Hao 2020-04-27  792  		ops->event_destroy(priv, event->hw.idx, event->hw.config_base);
724142f8c42a7b Wu Hao 2020-04-27  793  }
724142f8c42a7b Wu Hao 2020-04-27  794  
724142f8c42a7b Wu Hao 2020-04-27  795  static int fme_perf_event_init(struct perf_event *event)
724142f8c42a7b Wu Hao 2020-04-27  796  {
724142f8c42a7b Wu Hao 2020-04-27  797  	struct fme_perf_priv *priv = to_fme_perf_priv(event->pmu);
724142f8c42a7b Wu Hao 2020-04-27  798  	struct hw_perf_event *hwc = &event->hw;
724142f8c42a7b Wu Hao 2020-04-27  799  	struct fme_perf_event_ops *ops;
724142f8c42a7b Wu Hao 2020-04-27  800  	u32 eventid, evtype, portid;
724142f8c42a7b Wu Hao 2020-04-27  801  
724142f8c42a7b Wu Hao 2020-04-27  802  	/* test the event attr type check for PMU enumeration */
724142f8c42a7b Wu Hao 2020-04-27  803  	if (event->attr.type != event->pmu->type)
724142f8c42a7b Wu Hao 2020-04-27  804  		return -ENOENT;
724142f8c42a7b Wu Hao 2020-04-27  805  
724142f8c42a7b Wu Hao 2020-04-27  806  	/*
724142f8c42a7b Wu Hao 2020-04-27  807  	 * fme counters are shared across all cores.
724142f8c42a7b Wu Hao 2020-04-27  808  	 * Therefore, it does not support per-process mode.
724142f8c42a7b Wu Hao 2020-04-27  809  	 * Also, it does not support event sampling mode.
724142f8c42a7b Wu Hao 2020-04-27  810  	 */
724142f8c42a7b Wu Hao 2020-04-27  811  	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
724142f8c42a7b Wu Hao 2020-04-27  812  		return -EINVAL;
724142f8c42a7b Wu Hao 2020-04-27  813  
724142f8c42a7b Wu Hao 2020-04-27  814  	if (event->cpu < 0)
724142f8c42a7b Wu Hao 2020-04-27  815  		return -EINVAL;
724142f8c42a7b Wu Hao 2020-04-27  816  
724142f8c42a7b Wu Hao 2020-04-27  817  	if (event->cpu != priv->cpu)
724142f8c42a7b Wu Hao 2020-04-27  818  		return -EINVAL;
724142f8c42a7b Wu Hao 2020-04-27  819  
724142f8c42a7b Wu Hao 2020-04-27 @820  	eventid = get_event(event->attr.config);
724142f8c42a7b Wu Hao 2020-04-27  821  	portid = get_portid(event->attr.config);
724142f8c42a7b Wu Hao 2020-04-27  822  	evtype = get_evtype(event->attr.config);
724142f8c42a7b Wu Hao 2020-04-27  823  	if (evtype > FME_EVTYPE_MAX)
724142f8c42a7b Wu Hao 2020-04-27  824  		return -EINVAL;
724142f8c42a7b Wu Hao 2020-04-27  825  
724142f8c42a7b Wu Hao 2020-04-27  826  	hwc->event_base = evtype;
724142f8c42a7b Wu Hao 2020-04-27  827  	hwc->idx = (int)eventid;
724142f8c42a7b Wu Hao 2020-04-27  828  	hwc->config_base = portid;
724142f8c42a7b Wu Hao 2020-04-27  829  
724142f8c42a7b Wu Hao 2020-04-27  830  	event->destroy = fme_perf_event_destroy;
724142f8c42a7b Wu Hao 2020-04-27  831  
724142f8c42a7b Wu Hao 2020-04-27  832  	dev_dbg(priv->dev, "%s event=0x%x, evtype=0x%x, portid=0x%x,\n",
724142f8c42a7b Wu Hao 2020-04-27  833  		__func__, eventid, evtype, portid);
724142f8c42a7b Wu Hao 2020-04-27  834  
724142f8c42a7b Wu Hao 2020-04-27  835  	ops = get_event_ops(evtype);
724142f8c42a7b Wu Hao 2020-04-27  836  	if (ops->event_init)
724142f8c42a7b Wu Hao 2020-04-27  837  		return ops->event_init(priv, eventid, portid);
724142f8c42a7b Wu Hao 2020-04-27  838  
724142f8c42a7b Wu Hao 2020-04-27  839  	return 0;
724142f8c42a7b Wu Hao 2020-04-27  840  }
724142f8c42a7b Wu Hao 2020-04-27  841  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
Ifu3AQA=

--uAKRQypu60I7Lcqm--
