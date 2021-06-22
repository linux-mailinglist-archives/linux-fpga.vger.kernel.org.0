Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC33B1054
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Jun 2021 01:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhFVXHZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Jun 2021 19:07:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:9603 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVXHZ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 22 Jun 2021 19:07:25 -0400
IronPort-SDR: cyF1Tb6MHP29UX4LJNYQL91KacWF4QBD0P29zT9YImSM7rdxyV3WqbNB4DnMyugF9BlraztVYO
 CVRDFrbAbZSQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="268297297"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="268297297"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:05:08 -0700
IronPort-SDR: lmr9KzZ0Jr3UdeqhA8XP9ReJEauPIPIbga818cOFrRSIBSxv6S0yatNrAGJqSJ4vJqANnHfcKS
 An98oolUikjA==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="406120316"
Received: from rhweight-mobl2.amr.corp.intel.com (HELO [10.0.2.4]) ([10.209.27.104])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 16:05:08 -0700
Subject: Re: [PATCH v6 2/3] fpga: bridge: Use standard dev_release for class
 driver
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org, trix@redhat.com,
        lgoncalv@redhat.com, hao.wu@intel.com, matthew.gerlach@intel.com,
        richard.gong@intel.com
References: <20210621222249.451387-1-russell.h.weight@intel.com>
 <20210621222249.451387-3-russell.h.weight@intel.com>
 <20210622080253.GD27046@yilunxu-OptiPlex-7050>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <1e73f951-5708-5fe4-5a32-24200e5862ee@intel.com>
Date:   Tue, 22 Jun 2021 16:04:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622080253.GD27046@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 6/22/21 1:02 AM, Xu Yilun wrote:
> On Mon, Jun 21, 2021 at 03:22:48PM -0700, Russ Weight wrote:
>> The FPGA bridge class driver data structure is being treated as a
>> managed resource instead of using standard dev_release call-back
>> to release the class data structure. This change removes the
>> managed resource code and combines the create() and register()
>> functions into a single register() function.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>> v6:
>>   - Changed fpga_bridge_register() parameters to accept an info data
>>     structure to provide flexibility in passing optional parameters.
>>   - Added fpga_bridge_register_simple() function to support current
>>     parameters for users that don't require the use of optional
>>     parameters.
>> v5:
>>   - Rebased on top of recently accepted patches.
>> v4:
>>   - Restore the previous format for the Return value in the comment header
>>     for fpga_bridge_register()
>> v3:
>>   - Cleaned up comment header for fpga_bridge_register()
>>   - Fix error return values for fpga_bridge_register()
>> v2:
>>   - No changes
>>  drivers/fpga/altera-fpga2sdram.c    |  12 +--
>>  drivers/fpga/altera-freeze-bridge.c |  10 +--
>>  drivers/fpga/altera-hps2fpga.c      |  12 +--
>>  drivers/fpga/dfl-fme-br.c           |  10 +--
>>  drivers/fpga/fpga-bridge.c          | 133 +++++++++-------------------
>>  drivers/fpga/xilinx-pr-decoupler.c  |  17 ++--
>>  include/linux/fpga/fpga-bridge.h    |  33 +++++--
>>  7 files changed, 91 insertions(+), 136 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
>> index a78e49c63c64..e165440ebbab 100644
>> --- a/drivers/fpga/altera-fpga2sdram.c
>> +++ b/drivers/fpga/altera-fpga2sdram.c
>> @@ -121,17 +121,13 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>>  	/* Get f2s bridge configuration saved in handoff register */
>>  	regmap_read(sysmgr, SYSMGR_ISWGRP_HANDOFF3, &priv->mask);
>>  
>> -	br = devm_fpga_bridge_create(dev, F2S_BRIDGE_NAME,
>> -				     &altera_fpga2sdram_br_ops, priv);
>> -	if (!br)
>> -		return -ENOMEM;
>> +	br = fpga_bridge_register_simple(dev, F2S_BRIDGE_NAME,
>> +					 &altera_fpga2sdram_br_ops, priv);
>> +	if (IS_ERR(br))
>> +		return PTR_ERR(mgr);
>>  
>>  	platform_set_drvdata(pdev, br);
>>  
>> -	ret = fpga_bridge_register(br);
>> -	if (ret)
>> -		return ret;
>> -
>>  	dev_info(dev, "driver initialized with handoff %08x\n", priv->mask);
>>  
>>  	if (!of_property_read_u32(dev->of_node, "bridge-enable", &enable)) {
>> diff --git a/drivers/fpga/altera-freeze-bridge.c b/drivers/fpga/altera-freeze-bridge.c
>> index dd58c4aea92e..4e39b5475630 100644
>> --- a/drivers/fpga/altera-freeze-bridge.c
>> +++ b/drivers/fpga/altera-freeze-bridge.c
>> @@ -244,14 +244,14 @@ static int altera_freeze_br_probe(struct platform_device *pdev)
>>  
>>  	priv->base_addr = base_addr;
>>  
>> -	br = devm_fpga_bridge_create(dev, FREEZE_BRIDGE_NAME,
>> -				     &altera_freeze_br_br_ops, priv);
>> -	if (!br)
>> -		return -ENOMEM;
>> +	br = fpga_bridge_register_simple(dev, FREEZE_BRIDGE_NAME,
>> +					 &altera_freeze_br_br_ops, priv);
>> +	if (IS_ERR(br))
>> +		return PTR_ERR(br);
>>  
>>  	platform_set_drvdata(pdev, br);
>>  
>> -	return fpga_bridge_register(br);
>> +	return 0;
>>  }
>>  
>>  static int altera_freeze_br_remove(struct platform_device *pdev)
>> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
>> index 77b95f251821..a564eb29349c 100644
>> --- a/drivers/fpga/altera-hps2fpga.c
>> +++ b/drivers/fpga/altera-hps2fpga.c
>> @@ -180,19 +180,15 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>>  		}
>>  	}
>>  
>> -	br = devm_fpga_bridge_create(dev, priv->name,
>> -				     &altera_hps2fpga_br_ops, priv);
>> -	if (!br) {
>> -		ret = -ENOMEM;
>> +	br = fpga_bridge_register_simple(dev, priv->name,
>> +					 &altera_hps2fpga_br_ops, priv);
>> +	if (IS_ERR(br)) {
>> +		ret = PTR_ERR(br);
>>  		goto err;
>>  	}
>>  
>>  	platform_set_drvdata(pdev, br);
>>  
>> -	ret = fpga_bridge_register(br);
>> -	if (ret)
>> -		goto err;
>> -
>>  	return 0;
>>  
>>  err:
>> diff --git a/drivers/fpga/dfl-fme-br.c b/drivers/fpga/dfl-fme-br.c
>> index 3ff9f3a687ce..0ad39e502142 100644
>> --- a/drivers/fpga/dfl-fme-br.c
>> +++ b/drivers/fpga/dfl-fme-br.c
>> @@ -68,14 +68,14 @@ static int fme_br_probe(struct platform_device *pdev)
>>  
>>  	priv->pdata = dev_get_platdata(dev);
>>  
>> -	br = devm_fpga_bridge_create(dev, "DFL FPGA FME Bridge",
>> -				     &fme_bridge_ops, priv);
>> -	if (!br)
>> -		return -ENOMEM;
>> +	br = fpga_bridge_register_simple(dev, "DFL FPGA FME Bridge",
>> +					 &fme_bridge_ops, priv);
>> +	if (IS_ERR(br))
>> +		return PTR_ERR(br);
>>  
>>  	platform_set_drvdata(pdev, br);
>>  
>> -	return fpga_bridge_register(br);
>> +	return 0;
>>  }
>>  
>>  static int fme_br_remove(struct platform_device *pdev)
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index 798f55670646..1436acfc1e7d 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -312,55 +312,57 @@ static struct attribute *fpga_bridge_attrs[] = {
>>  ATTRIBUTE_GROUPS(fpga_bridge);
>>  
>>  /**
>> - * fpga_bridge_create - create and initialize a struct fpga_bridge
>> + * fpga_bridge_register - create and register an FPGA Bridge device
>>   * @parent:	FPGA bridge device from pdev
>> - * @name:	FPGA bridge name
>> - * @br_ops:	pointer to structure of fpga bridge ops
>> - * @priv:	FPGA bridge private data
>> + * @info:	parameters for FPGA Bridge
>>   *
>> - * The caller of this function is responsible for freeing the bridge with
>> - * fpga_bridge_free().  Using devm_fpga_bridge_create() instead is recommended.
> Mm.. The comments are removed. Do we need a devm version of
> fpga_bridge_register? Or leave it in later patches?

There never was a devm_fpga_bridge_register() function. All callers to
fpga_bridge_register() also call fpga_bridge_unregister(). If there is a desire to add
this functionality, I think it could be done in a separate patch set.

>
>> - *
>> - * Return: struct fpga_bridge or NULL
>> + * Return: struct fpga_bridge pointer or ERR_PTR()
>>   */
>> -struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
>> -				       const struct fpga_bridge_ops *br_ops,
>> -				       void *priv)
>> +struct fpga_bridge *fpga_bridge_register(struct device *parent,
>> +					 struct fpga_bridge_info *info)
> 				   const struct fpga_bridge_info
Yes, I'll add const to the functions prototypes and definitions.

>
>>  {
>>  	struct fpga_bridge *bridge;
>>  	int id, ret;
>>  
>> -	if (!name || !strlen(name)) {
>> +	if (!info->name || !strlen(info->name)) {
>>  		dev_err(parent, "Attempt to register with no name!\n");
>> -		return NULL;
>> +		return ERR_PTR(-EINVAL);
>>  	}
> Is it necessary to add if(!info->br_ops) check, the field is mandatory for
> fpga_bridge.
Yes, I'll add this.
>
>>  
>>  	bridge = kzalloc(sizeof(*bridge), GFP_KERNEL);
>>  	if (!bridge)
>> -		return NULL;
>> +		return ERR_PTR(-ENOMEM);
>>  
>>  	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
>> -	if (id < 0)
>> +	if (id < 0) {
>> +		ret = id;
>>  		goto error_kfree;
>> +	}
>>  
>>  	mutex_init(&bridge->mutex);
>>  	INIT_LIST_HEAD(&bridge->node);
>>  
>> -	bridge->name = name;
>> -	bridge->br_ops = br_ops;
>> -	bridge->priv = priv;
>> +	bridge->name = info->name;
>> +	bridge->br_ops = info->br_ops;
>> +	bridge->priv = info->priv;
>>  
>> -	device_initialize(&bridge->dev);
>> -	bridge->dev.groups = br_ops->groups;
>> +	bridge->dev.groups = info->br_ops->groups;
>>  	bridge->dev.class = fpga_bridge_class;
>>  	bridge->dev.parent = parent;
>>  	bridge->dev.of_node = parent->of_node;
>>  	bridge->dev.id = id;
>> +	of_platform_populate(bridge->dev.of_node, NULL, NULL, &bridge->dev);
>>  
>>  	ret = dev_set_name(&bridge->dev, "br%d", id);
>>  	if (ret)
>>  		goto error_device;
>>  
>> +	ret = device_register(&bridge->dev);
>> +	if (ret) {
>> +		put_device(&bridge->dev);
>> +		return ERR_PTR(ret);
>> +	}
>> +
>>  	return bridge;
>>  
>>  error_device:
>> @@ -368,90 +370,37 @@ struct fpga_bridge *fpga_bridge_create(struct device *parent, const char *name,
>>  error_kfree:
>>  	kfree(bridge);
>>  
>> -	return NULL;
>> -}
>> -EXPORT_SYMBOL_GPL(fpga_bridge_create);
>> -
>> -/**
>> - * fpga_bridge_free - free an fpga bridge created by fpga_bridge_create()
>> - * @bridge:	FPGA bridge struct
>> - */
>> -void fpga_bridge_free(struct fpga_bridge *bridge)
>> -{
>> -	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
>> -	kfree(bridge);
>> -}
>> -EXPORT_SYMBOL_GPL(fpga_bridge_free);
>> -
>> -static void devm_fpga_bridge_release(struct device *dev, void *res)
>> -{
>> -	struct fpga_bridge *bridge = *(struct fpga_bridge **)res;
>> -
>> -	fpga_bridge_free(bridge);
>> +	return ERR_PTR(ret);
>>  }
>> +EXPORT_SYMBOL_GPL(fpga_bridge_register);
>>  
>>  /**
>> - * devm_fpga_bridge_create - create and init a managed struct fpga_bridge
>> + * fpga_bridge_register_simple - create and register an FPGA Bridge device
>>   * @parent:	FPGA bridge device from pdev
>>   * @name:	FPGA bridge name
>>   * @br_ops:	pointer to structure of fpga bridge ops
>>   * @priv:	FPGA bridge private data
>>   *
>> - * This function is intended for use in an FPGA bridge driver's probe function.
>> - * After the bridge driver creates the struct with devm_fpga_bridge_create(), it
>> - * should register the bridge with fpga_bridge_register().  The bridge driver's
>> - * remove function should call fpga_bridge_unregister().  The bridge struct
>> - * allocated with this function will be freed automatically on driver detach.
>> - * This includes the case of a probe function returning error before calling
>> - * fpga_bridge_register(), the struct will still get cleaned up.
>> - *
>> - *  Return: struct fpga_bridge or NULL
>> - */
>> -struct fpga_bridge
>> -*devm_fpga_bridge_create(struct device *parent, const char *name,
>> -			 const struct fpga_bridge_ops *br_ops, void *priv)
>> -{
>> -	struct fpga_bridge **ptr, *bridge;
>> -
>> -	ptr = devres_alloc(devm_fpga_bridge_release, sizeof(*ptr), GFP_KERNEL);
>> -	if (!ptr)
>> -		return NULL;
>> -
>> -	bridge = fpga_bridge_create(parent, name, br_ops, priv);
>> -	if (!bridge) {
>> -		devres_free(ptr);
>> -	} else {
>> -		*ptr = bridge;
>> -		devres_add(parent, ptr);
>> -	}
>> -
>> -	return bridge;
>> -}
>> -EXPORT_SYMBOL_GPL(devm_fpga_bridge_create);
>> -
>> -/**
>> - * fpga_bridge_register - register an FPGA bridge
>> + * This simple version of the register should be sufficient for most users.
>> + * The fpga_mgr_register function is available for users that need to pass
>           fpga_bridge_register

Yes - I'll fix it.
>
>> + * additional, optional parameters.
>>   *
>> - * @bridge: FPGA bridge struct
>> - *
>> - * Return: 0 for success, error code otherwise.
>> + * Return: struct fpga_bridge pointer or ERR_PTR()
>>   */
>> -int fpga_bridge_register(struct fpga_bridge *bridge)
>> +struct fpga_bridge *
>> +fpga_bridge_register_simple(struct device *parent, const char *name,
>> +			    const struct fpga_bridge_ops *br_ops,
>> +			    void *priv)
>>  {
>> -	struct device *dev = &bridge->dev;
>> -	int ret;
>> -
>> -	ret = device_add(dev);
>> -	if (ret)
>> -		return ret;
>> +	struct fpga_bridge_info info = { 0 };
>>  
>> -	of_platform_populate(dev->of_node, NULL, NULL, dev);
>> +	info.name = name;
>> +	info.br_ops = br_ops;
>> +	info.priv = priv;
>>  
>> -	dev_info(dev->parent, "fpga bridge [%s] registered\n", bridge->name);
>> -
>> -	return 0;
>> +	return fpga_bridge_register(parent, &info);
>>  }
>> -EXPORT_SYMBOL_GPL(fpga_bridge_register);
>> +EXPORT_SYMBOL_GPL(fpga_bridge_register_simple);
>>  
>>  /**
>>   * fpga_bridge_unregister - unregister an FPGA bridge
>> @@ -475,6 +424,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
>>  
>>  static void fpga_bridge_dev_release(struct device *dev)
>>  {
>> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> +
>> +	ida_simple_remove(&fpga_bridge_ida, bridge->dev.id);
>> +	kfree(bridge);
>>  }
>>  
>>  static int __init fpga_bridge_dev_init(void)
>> diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
>> index ea2bde6e5bc4..24bc16a86091 100644
>> --- a/drivers/fpga/xilinx-pr-decoupler.c
>> +++ b/drivers/fpga/xilinx-pr-decoupler.c
>> @@ -138,22 +138,17 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
>>  
>>  	clk_disable(priv->clk);
>>  
>> -	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
>> -				     &xlnx_pr_decoupler_br_ops, priv);
>> -	if (!br) {
>> -		err = -ENOMEM;
>> -		goto err_clk;
>> -	}
>> -
>> -	platform_set_drvdata(pdev, br);
>> -
>> -	err = fpga_bridge_register(br);
>> -	if (err) {
>> +	br = fpga_bridge_register_simple(&pdev->dev, priv->ipconfig->name,
>> +					 &xlnx_pr_decoupler_br_ops, priv);
>> +	if (IS_ERR(br)) {
>> +		err = PTR_ERR(br);
>>  		dev_err(&pdev->dev, "unable to register %s",
>>  			priv->ipconfig->name);
>>  		goto err_clk;
>>  	}
>>  
>> +	platform_set_drvdata(pdev, br);
>> +
>>  	return 0;
>>  
>>  err_clk:
>> diff --git a/include/linux/fpga/fpga-bridge.h b/include/linux/fpga/fpga-bridge.h
>> index 6c3c28806ff1..e111698012f0 100644
>> --- a/include/linux/fpga/fpga-bridge.h
>> +++ b/include/linux/fpga/fpga-bridge.h
>> @@ -22,6 +22,23 @@ struct fpga_bridge_ops {
>>  	const struct attribute_group **groups;
>>  };
>>  
>> +/**
>> + * struct fpga_bridge_info - collection of parameters an FPGA Bridge
>> + * @name: fpga bridge name
>> + * @br_ops: pointer to structure of fpga bridge ops
>> + * @priv: fpga bridge private data
>> + *
>> + * fpga_bridge_info contains parameters for the register function. These
>> + * are separated into an info structure because they some are optional
>> + * others could be added to in the future. The info structure facilitates
>> + * maintaining a stable API.
>> + */
>> +struct fpga_bridge_info {
>> +	const char *name;
>> +	const struct fpga_bridge_ops *br_ops;
>> +	void *priv;
>> +};
>> +
>>  /**
>>   * struct fpga_bridge - FPGA bridge structure
>>   * @name: name of low level FPGA bridge
>> @@ -62,15 +79,13 @@ int of_fpga_bridge_get_to_list(struct device_node *np,
>>  			       struct fpga_image_info *info,
>>  			       struct list_head *bridge_list);
>>  
>> -struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
>> -				       const struct fpga_bridge_ops *br_ops,
>> -				       void *priv);
>> -void fpga_bridge_free(struct fpga_bridge *br);
>> -int fpga_bridge_register(struct fpga_bridge *br);
>> -void fpga_bridge_unregister(struct fpga_bridge *br);
>> +struct fpga_bridge *
>> +fpga_bridge_register(struct device *dev, struct fpga_bridge_info *info);
> 			struct device *parent, const struct fpga_bridge_info *info
I'll make the change.

Thanks for the comments,
- Russ
>
>>  
>> -struct fpga_bridge
>> -*devm_fpga_bridge_create(struct device *dev, const char *name,
>> -			 const struct fpga_bridge_ops *br_ops, void *priv);
>> +struct fpga_bridge *
>> +fpga_bridge_register_simple(struct device *dev, const char *name,
>> +			    const struct fpga_bridge_ops *br_ops,
>> +			    void *priv);
>> +void fpga_bridge_unregister(struct fpga_bridge *br);
>>  
>>  #endif /* _LINUX_FPGA_BRIDGE_H */
>> -- 
>> 2.25.1

